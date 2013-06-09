From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 21:17:56 -0500
Message-ID: <CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
	<1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
	<CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
	<CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
	<20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 04:18:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlVCm-0007W3-KM
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 04:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349Ab3FICR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 22:17:59 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:33015 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab3FICR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 22:17:58 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so1135019lbi.6
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 19:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=h/YVPJUIu/LzpIm5wJf1szOGImOmtGdGXxUV5Q7CnQI=;
        b=amzWyXXCY5Qu2SzZ72AfdBwqyB/ddOeKS/XohGshzw/mrWUrRpwLgUj+YFleB9tXRe
         fKTf24ORLnbkd0xD9evNIYxmYbsZTPOC524CLLXw0Q+P3Yd86V0sviMtNUfKPfNP49qV
         2c0OOwLdGocxzPptRf5WXUycd+fd7UrCKHR54ldNBuil3TXrt0e0w5wLj+iHh5LazLTU
         KW8ON+sFoYzflfLj0Wdsaaz3JGl/gk0zpP+qjDYtnNxdlOPbSvdopByUP1kFH9OTIQH/
         w5QfGizZ0fNGx3z+Q7tMx9iETzN5fu6KxwPvOx+1fZJqURy3RakMQqnpUJHKDSGz34ve
         iWTA==
X-Received: by 10.152.22.130 with SMTP id d2mr1724226laf.33.1370744276571;
 Sat, 08 Jun 2013 19:17:56 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 19:17:56 -0700 (PDT)
In-Reply-To: <20130609014049.GA10375@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226869>

On Sat, Jun 8, 2013 at 8:40 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>> Just the past three months I've probably done more work than anybody
>> else[1], and you would ban me because you don't like my words?
>
> Definitely, yes.  Even if you look at the impact on code alone and
> don't care about the people, destroying a collegial work environment
> is harmful enough to the code to outweigh the (admittedly often
> useful) patches.

A collegial work environment is overrated, and proof of that the Linux
kernel, where honest and straight talk is the bread and butter of the
mailing list. And the Linux kernel is the most successful software
project in history by far. It's code that speaks.

And I have not destroyed anything, except maybe your sense of fairness
and balance when reviewing my patches, but that is not my fault.

-- 
Felipe Contreras
