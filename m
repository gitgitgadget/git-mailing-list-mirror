From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sat, 8 Jun 2013 10:34:47 -0700
Message-ID: <20130608173447.GA4381@elie.Belkin>
References: <1370643409-3431-1-git-send-email-felipe.contreras@gmail.com>
 <1370643409-3431-3-git-send-email-felipe.contreras@gmail.com>
 <CACsJy8AMMCWSFC6EUHAgZdDA7E1kSPE3ZO6qGvS+WGji-di=Rw@mail.gmail.com>
 <CAMP44s29GiGJq3wyXAzJNo0FJY+Vbgd18bpBJMYQ47h-3M6sWA@mail.gmail.com>
 <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <20130608164902.GA3109@elie.Belkin>
 <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 19:35:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlN2y-0005do-Qq
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 19:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515Ab3FHRfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 13:35:19 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:39719 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab3FHRfS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 13:35:18 -0400
Received: by mail-pd0-f180.google.com with SMTP id 10so5944117pdi.25
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 10:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=s7svhsRBUAQCzVGDHm26RWdFbRegKwq2D4Up8G8Oz38=;
        b=bQ/W15AdsdA8IzfggHjLRnoBS2B25jCiPJwaVg3XfL+VSvTl35bdRt3Hp++pB5P957
         egdrJos+cGR4YfpRG38p5oaiEICf7v0/CujaSlLBMCenVJzJaqPoROZ3FIGU6i9G0P/Y
         EzMMJxHl5t2MH1dxf020DCitI0ELAFvn5+s5ASbjruut3Kw7TAZUXm4CD6VZrU2ocZFA
         WzR0uNmGhdXIeRw50yPKMCrXIP3QHk3kyyOJl8f6hudPysX9dPFACBNykTPYVPPCpSmd
         6JNpiTKBRXkY1UqbmmmsDEOoI1NJ0gBXA65X01kZcpZD0xV86PwvdBw5UhAghRdfMpX+
         MGyg==
X-Received: by 10.68.244.73 with SMTP id xe9mr2565531pbc.119.1370712917594;
        Sat, 08 Jun 2013 10:35:17 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id do4sm3748587pbc.8.2013.06.08.10.35.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 10:35:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226847>

Felipe Contreras wrote:

> This has nothing to do with better strategy, it has everything to do
> with gut feelings and tradition. Not reasons.

I try to help you, and you insult me.  I don't think this is worth it.

If I were managing this list, I would ban mails from you, since this
discussion style does more harm than good.  If I were maintaining git,
I'd still accept your contributions, waiting until times when I had
more patience to read them and sending them to the list when
appropriate to get more feedback.  Of course I am neither managing the
list nor maintaining git, but I thought I should put that out there...

Annoyed,
Jonathan
