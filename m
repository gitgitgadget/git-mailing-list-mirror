From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 1/1] Makefile: make curl-config path configurable
Date: Wed, 21 Oct 2015 12:36:39 -0700
Message-ID: <20151021193639.GC7881@google.com>
References: <1445447446-21748-1-git-send-email-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Wed Oct 21 21:37:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZozC7-0006JX-7N
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 21:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671AbbJUTgo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 15:36:44 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36492 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755737AbbJUTgm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 15:36:42 -0400
Received: by pacfv9 with SMTP id fv9so65767538pac.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 12:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JC5RLR26uGRhENofWHucdjJoTv7XmR4dnW76tBo16X4=;
        b=g8mQ7/Pn2ul7PMtU3kT7uhaFqlmFRL14a9Rpr8vCs3eHYOr6hV1uAHTlyfpb9+T34z
         DwlsO9TKwUic84+cGGiakjWjqSCmBZ+vkxcwjg9tmYgHScz4GVqQ86D9mArjqkm48b4Z
         vbkne9VbOdUkOIbMOxO2LXtU12gc/TMtmcQtvwwB5xUlYB8stLd4kRkd8Jm+Js/iNlzP
         BZbgwVYPtPBrpa9GywFB3zBoSXjk8mKY0FvGyWHiYZzTrU3Kr2DOmFrPMok8YgfauV3q
         dhrciXF6jxm/IxMsSDTXyI5FGMpc6k06sRu/hFpyLofeDZuVIATZhUQYuZSkdlA43ddH
         Cagw==
X-Received: by 10.68.168.226 with SMTP id zz2mr12519724pbb.8.1445456201893;
        Wed, 21 Oct 2015 12:36:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:7dd2:6501:e4d0:3159])
        by smtp.gmail.com with ESMTPSA id zn9sm10571479pac.48.2015.10.21.12.36.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Oct 2015 12:36:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1445447446-21748-1-git-send-email-repk@triplefau.lt>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280002>

Remi Pommarel wrote:

> Signed-off-by: Remi Pommarel <repk@triplefau.lt>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yep. ;)

Thanks.
