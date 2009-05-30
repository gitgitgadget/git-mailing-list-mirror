From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFH] Questions for Git User's Survey 2009
Date: Sat, 30 May 2009 12:45:14 +0300
Message-ID: <94a0d4530905300245nc3b46b7p6a29fbee2cebf8cd@mail.gmail.com>
References: <200905291855.03328.jnareb@gmail.com>
	 <94a0d4530905300153l361ed7d9l4376cb4c85001772@mail.gmail.com>
	 <200905301139.26737.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 30 11:45:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAL81-0001lQ-4M
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 11:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbZE3JpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 05:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754355AbZE3JpP
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 05:45:15 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:57539 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbZE3JpO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 05:45:14 -0400
Received: by fg-out-1718.google.com with SMTP id d23so195718fga.17
        for <git@vger.kernel.org>; Sat, 30 May 2009 02:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=bhyI9PqG+rN7wDZJorBAl7st1qLC75StaMcMQViD6Aw=;
        b=W/mVpCyVcfpFRWkFMkfklLk22SHPYtc2N1HYOu8VTObvdyEIi+DNftXHd/jFJ9vQvQ
         tGbJKIldzCd0suzYcFdzGu0Ha7sGX9TDapbpsPyyO/xUCPG+MMVYygbFgQioe86vjhM5
         1A3sT8jBCrINvYP8ru4JjKc3Xz6TpF7ygPljU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jk7NjGHaRWDkXZdpNx21/2s90NNg/etAmVQz5gct8j2TAbN8cjyTT12+XPXXeaL857
         PCMIEECHXbb5CgJCv3/8gRG6lfqbIrHAS3tlWqEypFLv5Uvlrz7J0oyKITZeYtBKlGw2
         1AULZhjsfljKlJk0VyTr5dU+9+HkwNS++YhkQ=
Received: by 10.86.31.19 with SMTP id e19mr3900915fge.24.1243676714705; Sat, 
	30 May 2009 02:45:14 -0700 (PDT)
In-Reply-To: <200905301139.26737.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120344>

On Sat, May 30, 2009 at 12:39 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 30 May 2009, Felipe Contreras wrote:
>> On Fri, May 29, 2009 at 7:55 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>
> [...]
>> > So what I would like to have is to come up with a LIST OF QUESTIONS
>> > and possible answers; I'd like to limit number of questions with
>> > free-form part, and reduce number of free-form questions to absolute
>> > minimum; they are pain to analyse with so large number of responses.
>> >
>> > Please write also _why_ you would want a question; what we can learn
>> > from it, how it can help in developing git.
>> >
>> > Thanks in advance
>>
>> Personally I think last year's survey was great, but it was missing
>> questions regarding git's user interface. How good is it? What would
>> you improve, etc.
>
> The problem with this question is that it is free-form question (and
> not single or multiple choice one). With more than 3000 responses to
> last year survey free-form questions are not summarized till now.
> I'd rather limit number of free-form questions to absolute minimum.
>
> Hmmm... I wonder if the trend would continue, and we would get around
> 15,000 responses to this year survey (if there would be one)...

Yes free-form questions should be reduced, but IMHO this one should
stay. If there's only 2 free-form questions I'd pick
 * What would you improve in git's UI?
 * Any words you want to share with git developers?

-- 
Felipe Contreras
