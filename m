From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/1] Makefile: link libcurl before zlib
Date: Wed, 21 Oct 2015 12:35:14 -0700
Message-ID: <20151021193514.GB7881@google.com>
References: <1445446873-21294-1-git-send-email-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Wed Oct 21 21:35:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozAU-0004fo-9B
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 21:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755904AbbJUTfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 15:35:18 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36271 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737AbbJUTfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 15:35:17 -0400
Received: by pacfv9 with SMTP id fv9so65737341pac.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 12:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=6l/xFVh4GWMr8RRJn0Ps3+Cs2XasfbLfp6v3h6B4jA8=;
        b=OFBUSXGSZAL3M7cKCZNiu7JH46+fDmN9aqEpPuDdZfn/5qLmWl5vybSfeaixEGQuyW
         Z4VB0clwnRemRjaddLPPJ4pFRSutoueq0EnHkwfyPbk7Ej+K70zIyb1hoBwuImvVuv9T
         p61svAMt9wI/YWFphwpQbFRZwn6vVNvuNNF8wvPkLLrAhUHOrX74eFO+8sFrBdWD5kta
         ItIKWZC0OIMb3tyzv/tmy0zU3eashnXq4mb3Opk7z/QFRtLOQd7w2KS62Fl22jsjX8Kd
         C/J2J/JXRn7ruPjL+ZdwIkPTlCWwiEUbTByy04HzfwtCLJwntKjRbU1wR+AbDNdpfFT6
         7JYA==
X-Received: by 10.66.158.233 with SMTP id wx9mr12611435pab.157.1445456116981;
        Wed, 21 Oct 2015 12:35:16 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:7dd2:6501:e4d0:3159])
        by smtp.gmail.com with ESMTPSA id d2sm10552303pat.24.2015.10.21.12.35.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Oct 2015 12:35:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1445446873-21294-1-git-send-email-repk@triplefau.lt>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280001>

Remi Pommarel wrote:

> Signed-off-by: Remi Pommarel <repk@triplefau.lt>

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
