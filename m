From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/10] use the $( ... ) construct for command substitution
Date: Tue, 22 Dec 2015 13:33:07 -0800
Message-ID: <20151222213307.GB5243@google.com>
References: <1450796755-15848-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 22:33:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBUYV-0004ZW-Ri
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 22:33:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbbLVVdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 16:33:11 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34035 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933795AbbLVVdK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 16:33:10 -0500
Received: by mail-pa0-f50.google.com with SMTP id uo6so17796289pac.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 13:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=A+9tEceUS8DrIUEJPSEJ5FxFlAjpF46K/eEai71P7U0=;
        b=G9zUVatmojVN/nbTL4DrFzZOt9PAWgQr/JbI3jcCWx2X+bZ6Mls6VphCYL5HV4gyqy
         f3r6uctLW4tNMTREFvXbEKtyGqYiftdXX72mgEltvQ/CgW70F0W/x65Kj58uxZ4yVOet
         01Ztrcpjf3Y60GUmHJvytaLFkuDFlklyzIJnehZUBFZGBHp+6aUzqJJkeEeUX/mZqfrJ
         eJ7vKCR1kWuUKoSNymFyqJHbv4GonVYuoIIRyqIevadq5K12Q6o6Sy0W5PlBNh1RMJEG
         If9xF86lgLYUDGQYwGolpz1rGS12X+pxzWwiez9Y/Alc2ix23mJE+4B5U/vm5JkuzSSm
         X6dA==
X-Received: by 10.66.160.229 with SMTP id xn5mr39049308pab.0.1450819989900;
        Tue, 22 Dec 2015 13:33:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:e506:fd7e:5081:5912])
        by smtp.gmail.com with ESMTPSA id b88sm23138711pfj.11.2015.12.22.13.33.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Dec 2015 13:33:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1450796755-15848-1-git-send-email-gitter.spiros@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282910>

Elia Pinto wrote:

> This is the second series, the other will be sent separately.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
