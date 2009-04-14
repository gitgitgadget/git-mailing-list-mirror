From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 INTRO] I hope this will do it!
Date: Tue, 14 Apr 2009 13:50:43 -0500
Message-ID: <b4087cc50904141150y293d1696ude409ed6d0d7a0c3@mail.gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
	 <7vy6u36215.fsf@gitster.siamese.dyndns.org>
	 <b4087cc50904140926o4bb48c1bs66946078bb3cd2f9@mail.gmail.com>
	 <7vd4bf3weo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 20:52:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ltnk7-0002Ut-6Q
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 20:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994AbZDNSuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 14:50:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbZDNSup
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 14:50:45 -0400
Received: from mail-qy0-f117.google.com ([209.85.221.117]:59068 "EHLO
	mail-qy0-f117.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbZDNSuo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 14:50:44 -0400
Received: by qyk15 with SMTP id 15so1183229qyk.33
        for <git@vger.kernel.org>; Tue, 14 Apr 2009 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/CqDbNmWG9ksP+A75SXhblKwR+G2G7WKuNm7RoaDo/M=;
        b=Q0yq/TDOlww5U7F+QGFGTZzkdOKilvYyIYbM6MWY0cRS6Kw2QILlcxZGaC8/NuANXk
         7fkL3DB73ZE1KmwcVP35AWt1z5xi/RFuhM3Rx8xZTIuCk/rTmscNcjJ6ygPBzOYTiBlX
         t6NVT42bbL7ssG8A/JXq6Wpf4WHQNwzTdK5x0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hSqxaJ4LV07qaB7vuNosfljKDDhFpn5LtwTsrQhewZhvyLYeyPXA3LhKvlunUhHbQv
         RXro4DSoHs9NdbRl11EMQC0uaP084ze0oD8QJQEOTynNJVGlGy4sRXe9my862Vt6rnA/
         HwxgKwal39S3Hrzkj24iZjBI8NwVtrVy98BEI=
Received: by 10.224.67.66 with SMTP id q2mr1414311qai.261.1239735043586; Tue, 
	14 Apr 2009 11:50:43 -0700 (PDT)
In-Reply-To: <7vd4bf3weo.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116556>

On Tue, Apr 14, 2009 at 13:47, Junio C Hamano <gitster@pobox.com> wrote:
>>> It is unfortunate that the interesting ones begin at 10th in the series,
>>> which are beind the 9th one that is a "churn in the middle".
>>
>> (http://marc.info/?l=git&m=123959564630157&w=2):
>>> The general rule of thumb is to do such a clean-up before you start to work on something of substance.
>>
>> (http://marc.info/?l=git&m=123914648915106&w=2):
>>> a good rule of thumb when preparing a series is to have this kind of obvious clean-up first, leaving enhancement patches later in the series.
>>
>> I guess, then, this whitespace patch is something of substance---an
>> enhancement ;-D
>>
>> ... or unnecessary "code churn"... I suppose.
>
> An obviously good and uncontroversial clean-up should come first, so that
> it can be applied and meat of the change can be discussed on the cleaned
> base version.
>
> A clean-up that might be judged as a mere churn should come last, so that
> enhancements and fixes can go first without waiting for the controversy to
> settle.

I'm was just being facetious. In fact, I have already moved that patch
to the end on my side.
