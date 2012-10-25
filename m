From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Wed, 24 Oct 2012 21:27:31 -0700
Message-ID: <20121025042731.GA11243@elie.Belkin>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
 <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
 <20121024180807.GA3338@elie.Belkin>
 <CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
 <20121024191149.GA3120@elie.Belkin>
 <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Herman <eric@freesa.org>,
	Fernando Vezzosi <buccia@repnz.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 06:27:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRF2x-0003bR-On
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 06:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223Ab2JYE1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 00:27:43 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35172 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858Ab2JYE1l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 00:27:41 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so854608pad.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 21:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4ZOiFQfSzLHsXL1F6H89xeE2oJTxuWXhPf51m4j6sEw=;
        b=MRr/R22WkpgOapVtfE/x7O4htV2kmARVtidQTWJ56Bn7yMmG23y6zNkhdQ3qJh06M3
         qzuKUt8b9OIaF0RWf52yztUD6HAkdvkdLNLN/saOWO9Sw1sKAxOqwbgWS/Ld28Mop6qW
         9XZ1mVOQoDL5cCa7ZVQi3geNcDpyM4YfnqR8NIvIphR25DCIzVh+YWnpTAlu0sM713us
         eViS+95rvCmzE4BlmB0SocGaNLHT2QMa39VuEDWqHgzk2OpSA26tdkAkZFEMDFXAAZki
         GVTkP7QzUujW7nUsUeEQwdbOat/h+CCw/ee4OVC1yZpBi+cTP54swe1o6IDMbjRkMqVk
         /nGA==
Received: by 10.68.223.226 with SMTP id qx2mr39501249pbc.42.1351139261143;
        Wed, 24 Oct 2012 21:27:41 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id x8sm10605821paw.16.2012.10.24.21.27.38
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Oct 2012 21:27:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2kjv9fHbruXv7NyVm9m+FjFnYDryuPZQ-RQXN9Nj6MAw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208338>

Felipe Contreras wrote:

> Again, if you don't have marks, I don't see what you expect to be
> exported with 'master..master', even with marks, I don't see what you
> expect.

And that's fine.  Unless you were trying to do some work and this lack
of understanding got in the way.

In that case, with a calmer and more humble approach you might find
people willing to help you.  Maybe they will learn something from you,
too.

Ciao,
Jonathan
