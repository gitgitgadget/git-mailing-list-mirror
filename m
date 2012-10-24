From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t9350: point out that refs are not updated correctly
Date: Wed, 24 Oct 2012 12:11:49 -0700
Message-ID: <20121024191149.GA3120@elie.Belkin>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-2-git-send-email-srabbelier@gmail.com>
 <CAMP44s1hdZb_7Lv8SEe+MsfC_q-nXsnjJobABFq6eFR_er4TaA@mail.gmail.com>
 <20121024180807.GA3338@elie.Belkin>
 <CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Wed Oct 24 21:12:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR6N7-0004ed-Pj
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 21:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161135Ab2JXTL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 15:11:58 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:43161 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161085Ab2JXTL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 15:11:57 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so385877dak.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 12:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=HDw46itkoqHrMMb97dOoy9aVOECs/fzZeh5B3jpioqw=;
        b=yATGDzZ/kfpzFbWf+C9lFGtPe/RYyWtajXGmm/UeIWsfoIyjNwY3aGu8e+TSIRTzk6
         8TdEgrH9atEil4ZcW5fQeBAtgT84s2ALFStG0mFBXjgHBI3CilF2ximM9GcpN5GDkQQF
         tary7KsSTEDNFZueOrn86RagSzg3k5/xuc4Xi5boePnHb9A3Y7d5W25rNK524onbGZ90
         OV5E1LPpHPgdMXv4CUEO6SGCm0BKVqayChLuI+cjPiVek8V1rEcPXNRHWsFZ3Vv0UN/y
         QgScQ/GZWyTB0MmEvYiZDerHG7D32bWgQkQuVHfDG5G6R7gwahARJkcq+3HGElwc0wfk
         QKKw==
Received: by 10.68.189.132 with SMTP id gi4mr52431522pbc.111.1351105916965;
        Wed, 24 Oct 2012 12:11:56 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id hu5sm9845932pbc.72.2012.10.24.12.11.55
        (version=SSLv3 cipher=OTHER);
        Wed, 24 Oct 2012 12:11:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s2RspCrRXZbRTsVwezyU9X=+8RF=_9Q+3zX75LBJkdoPA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208319>

Felipe Contreras wrote:

> Does it mean that? I don't think so, but let's assume that's the case.
>
> We don't have all those commits; without the marks we have nothing. Or
> what exactly do you mean by 'we'?

Not everyone uses marks.

Ciao,
Jonathan
