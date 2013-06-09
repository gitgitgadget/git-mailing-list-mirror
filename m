From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 18:40:49 -0700
Message-ID: <20130609014049.GA10375@google.com>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
 <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <20130608164902.GA3109@elie.Belkin>
 <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
 <20130608173447.GA4381@elie.Belkin>
 <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 03:41:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlUcx-0004hO-PZ
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 03:41:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab3FIBk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 21:40:57 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46187 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab3FIBk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 21:40:56 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so5206002pdc.19
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 18:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=y1WND4N3qMoSURFZ2I/Gi4iWPVdXAG8xAwWku8gvJXc=;
        b=igd9KRHVcTR1B2EP1wdxS2r/2VRHRJnwuj3TONkr5ZqujxActoKiNn6QEAoNpH4MqP
         siHglgs1TAE6YCWdiCfd0XRoaZpP1ibBci+kMEnzkADd6i7BdktOeLeucwCrkj1KrS9E
         WD4wifD584bkG8mHVA3AWkI6Y30pftrJpafKz1nHL7iX0HHD6FQdkCFgaiXcAX1IfDrR
         gMEGgXHNZqz7lzUdg9ZDkeLhl7p6DxwXkZynZKrDY6HVJQB9jN8adhmS3JqsznsB//q/
         akF5Sk7yPh3YUC2FUBj82uLJ+nJTluurIfDqklROMDqfPd0s1qUmtbDJeJJGkXzHQi8J
         WIww==
X-Received: by 10.68.185.162 with SMTP id fd2mr4467261pbc.176.1370742056401;
        Sat, 08 Jun 2013 18:40:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id pb5sm4724323pbc.29.2013.06.08.18.40.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 18:40:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226867>

Felipe Contreras wrote:

> Just the past three months I've probably done more work than anybody
> else[1], and you would ban me because you don't like my words?

Definitely, yes.  Even if you look at the impact on code alone and
don't care about the people, destroying a collegial work environment
is harmful enough to the code to outweigh the (admittedly often
useful) patches.

But I am not the mailing list owner, so what I would do is not too
important.

Jonathan
