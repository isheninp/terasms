# https://terasms.ru/documentation/api/http

=begin  
  login	строка	обязательный параметр
  Логин на Платформе TERASMS
  
  sign	строка	Подпись запроса. Процедура формирования подписи описана в разделе Авторизация при использовании HTTP API.
  password	строка	Пароль партнёра на Платформе TERASMS. Может использоваться вместо параметра sign, однако использование подписи является рекомендуемым способом авторизации
  
  target	строка	обязательный параметр
  Для всех сообщений кроме e-mail — номер абонента в международном формате.
  Если необходимо отправить одно и то же сообщение нескольким абонентам, то номера абонентов можно задать через запятую.
  Пример: 79161111111
  Для самостоятельных e-mail сообщений — почтовый адрес получателя. Также допускается указывать несколько получателей через запятую/точку с запятой.
  Пример: mailbox@domain.com
  Для e-mail сообщений в составе «Каскада» — пара номер_телефона-почтовый_адрес, разделенные между собой двоеточием.
  В этом случае пара сохраняется в нашей системе и в дальнейшем можно указывать только номер телефона. Почтовый адрес, при необходимости, будет взят по этому номеру.
  Управление сохраненными связками также доступно по API и описано в разделе Отправка сообщений E-mail.
  Пример: 79161111111:mailbox@domain.com
  
  sender	строка	обязательный параметр
  Имя отправителя, зарегистрированное для вас на Платформе TERASMS. Имя отправителя, содержащее в себе латинские буквы (в любом регистре), может содержать от 2 до 11 символов, цифровое имя отправителя — от 2 до 15 символов.
  
  message	строка	обязательный параметр
  Текст сообщения. Текст 1 сообщения составляет 160 символов для латиницы и 70 символов для кириллицы. Сообщение, содержащее большее кол-во символов, разбивается на несколько сегментов и доставляется одним сообщением. Сообщение, состоящее более чем из 160 для латиницы или из 70 символов для кириллицы, разбивается на сегменты. Каждый сегмент составляет 153 для латиницы и 67 символов для кириллицы. По умолчанию сообщение может состоять максимум из 10 сегментов.
  
  email_message	массив	необязательный параметр
  Используется только при передаче в формате JSON.
  Предназначен для передачи параметров при отправке e-mail сообщений, как самостоятельных, так и в составе «Каскада».
    Поля массива:
    template_id — идентификатор предварительно загруженного шаблона
    from — почтовый адрес отправителя письма
    title — тема письма
    placeholders — массив подстановок, используемых в указанном шаблоне
    Если не указан и передается e-mail сообщение, то:
    адрес отправителя будет взят из настроек в Личном кабинете или, при его отсутствии, подставлен общий системный адрес;
    тема письма будет взята из настроек в Личном кабинете или, при ее отсутствии, подставлено значение параметра sender;
    шаблон текста письма — будет использован шаблон по умолчанию, настроенный в Личном кабинете. При его отсутствии будет отправлен просто текст, без использования шаблона.
    Более подробное описание находится в разделе Отправка сообщений E-mail.
  
  cp	1251	необязательный параметр
  По умолчанию предполагается, что текст SMS передается в кодировке utf-8. Если ваш текст в кодировке cp1251 (Windows-1251), нужно добавить параметр cp=1251.
  
  mass_push	1 или 0	необязательный параметр
  Если необходимо отправить разный текст сообщения каждому абоненту, необходимо добавить параметр mass_push=1, поле message оставить пустым, а в поле target передать номера абонентов и тексты сообщений. В этом случае номер телефона и сообщение разделяются одним пробелом, а символ для разделения сообщений можно задать с помощью параметра delimiter.
  
  delimiter	символ	необязательный параметр
  Символ для разделения сообщений в поле target. По умолчанию принимается символ перевода на новую строку \n.
  
  flash	1 или 0	необязательный параметр
  Для отправки сообщений в формате flash.
  
  relative_time	число	необязательный параметр
  Время в секундах, в течение которого предпринимаются попытки доставить сообщение. Если параметр не задан, по умолчанию от 24 до 72 часов в зависимости от оператора.
  
  relative_time_read	число	необязательный параметр
  Время в секундах, в течение которого ожидается отчет о просмотре/прочтении сообщения, где это применимо (мессенджеры Viber, Telegram и т.п.).
  
  date_schedule	строка	необязательный параметр
  Дата и время отложенной отправки сообщения, задается в формате Y-m-d H:i:s. Если задан параметр timezone=1, то платформа сама определит часовой пояс абонента и скорректирует время отправки с учетом этих данных. Время отложенной отправки не должно превышать 30 дней от текущего времени. Если timezone не задан, отправка производится в по московскому времени (GMT +3).
  timezone	1	необязательный параметр
  Указывает учитывать ли часовой пояс абонента при отложенной отправке. Для определения часового пояса абонента номер должен принадлежать российским сотовым операторам, в противном случае планирование идет по московскому времени (GMT +3).
  
  time_from	дата и время в формате Y-m-d H:i:s (пример 2017-06-01 17:30:00)	необязательный параметр (требует time_to)
  Вместе с time_to задает временное окно для отправки смс абоненту с учетом часового пояса. Номер должен принадлежать российским сотовым операторам, если не удалось определить часовой пояс абонента сообщение отправляется сразу
  В случае неверного формата даты возвращается код ошибки -130.
  Если указанное время в регионе абонента еще не наступило, дата отправки откладывается на дату старта (time_from)
  Если временное окно в регионе абонента уже прошло, но мы попадаем в рамки по времени на текущюю дату, то смс уходит сразу. Если смс не попадает в рамки и время прошло, переносим на дату старта на следующие сутки Если смс не попадает в рамки и время не наступило, оставляем текущую дату в регионе и время старта из time_from.
  
  time_to	дата и время в формате Y-m-d H:i:s (пример 2017-06-01 20:30:30)	необязательный параметр (требует time_from)
  Вместе с time_from задает временное окно для отправки смс абоненту с учетом часового пояса.
  schedule_id	ID рассылки, созданной с помощью метода add_delivery	необязательный параметр
  Позволяет указать ID именованной рассылки для группировки сообщений. Подробнее об именованных рассылках можно прочитать в описании HTTP API.
  type
=end

require 'rubygems'
require 'ostruct'
require 'terasms/http_client/base'
require 'json'
  
module Terasms
  
  def self.config
    @config ||= OpenStruct.new
  end
      
  # url, login, password, sign
  def self.configure
    yield(config)
  end

  class Sms < HttpClient

    ERRORS = {
      -1 => 'Неверный логин или пароль',
      -20 => 'Пустой текст сообщения',
      -30 => 'Пустой номер абонента',
      -40 => 'Неправильно задан номер абонента',
      -45 => 'Превышено количество номеров',
      -50 => 'Неправильно задано имя отправителя',
      -60 => 'Рассылка по данному направлению недоступна',
      -70 => 'Недостаточно средств на счете',
      -80 => 'Не установлена стоимость рассылки по данному направлению',
      -90 => 'Рассылка запрещена',
      -100 => 'Не указаны необходимые параметры',
      -110 => 'Номер в черном списке',
      -120 => 'Некорректно задано время отложенной отправки',
      -130 => 'Некорректно задано временное окно отправки',
      -140 => 'Передан некорректный ID рассылки',
      -160 => 'Превышен дневной лимит рассылки (Вы можете установить максимальную сумму ежедневной рассылки после согласования с Вашим менеджером)',
      -999 => 'Ошибка обработки ответа API'
    }

    def error code
      ERRORS[code]
    end

    def main_status result
      result["result"]["status"] rescue -999
    end
    
    def message_status result
      result["result"]["message_infos"].last["status"] rescue -999
    end

    def message_id result
      result["result"]["message_infos"].last["id"] rescue -999
    end

    # target, sender, message, 
    # cp, mass_push, delimiter, flash, relative_time, relative_time_read, date_schedule, timezone, time_from, time_to, schedule_id, type
    def send params
      result = submit Terasms.config.url, {}, 'POST', 'json', Terasms.config.to_h.tap{|hs| hs.delete(:url)}.merge(params).to_json
      if main_status(result) < 0
        result.merge!({"info"=> error(main_status(result)), "status"=>"error"}) 
      else
        if message_status(result) < 0
          result.merge!({"info"=> error(message_status(result)), "status"=>"error"}) 
        else
          result.merge!({"id"=> message_id(result)})
        end
      end
      result
    end
    
    def balance
      result =  submit Terasms.config.balance_url, {}, 'POST', 'json', Terasms.config.to_h.slice(:login, :password).to_json
      result.merge!({"info"=> error(main_status(result)), "status"=>"error"}) if main_status(result) < 0
      result
    end

    def statuses array_of_id
      submit(Terasms.config.status_url, {}, 'POST', 'json', Terasms.config.to_h.slice(:login, :password, :sign).merge({'message_ids': array_of_id}).to_json)
    end

    def status id
      begin
        raise 'wrong message id' if statuses([id])["result"]["statuses"] == []
        {"result"=> "success"}.merge(statuses([id])["result"]["statuses"].last.slice("status", "status_desc"))
      rescue => error
        {"result"=> "error", "info" => error.to_s}
      end
    end

  end
end
