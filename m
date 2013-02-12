From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] Fix installation paths with "make install-doc"
Date: Tue, 12 Feb 2013 14:25:08 -0800
Message-ID: <20130212222508.GG12240@google.com>
References: <cover.1360700102.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>,
	Jakub Narebski <jnareb@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:25:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5OIG-0007m4-As
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 23:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916Ab3BLWZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 17:25:14 -0500
Received: from mail-da0-f49.google.com ([209.85.210.49]:45474 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab3BLWZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 17:25:13 -0500
Received: by mail-da0-f49.google.com with SMTP id t11so238553daj.22
        for <git@vger.kernel.org>; Tue, 12 Feb 2013 14:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=n65r5vUQx+lWScpCse43A/MervukZJ7MU2vjiv+bFy8=;
        b=QBDToOJmlHHn+lV5VOZAsqHbQF+t5h3bSsXR7pwKSFZG6K07i13MUTee9+UaYVL5fp
         ECznfzIDECBUpjw390RflVraaHmZFb6qaHe6Vkbb4FXP0sOVLxlhp9ojUBHwJipHfy6A
         d++sldSLqx7OmX/Bc9FhB4elykD4IXkM89RGzlH9FLlo0m8C9dai1ui3SElNqTUqtAyQ
         higHvTmiBxgAca1yuKyqldPMVLQoNeMQzLepmVJzNx9Ji8T9h00qKWlVlbh0/TYQ+rTR
         5z2a9utiNokpLg+iR8t0AVXTDRiu7BFK0rNSByRqBswWNvthQpFr81sTM5LtVe5lqjLR
         LVRA==
X-Received: by 10.66.89.199 with SMTP id bq7mr56642762pab.26.1360707913133;
        Tue, 12 Feb 2013 14:25:13 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id y9sm78147295paw.1.2013.02.12.14.25.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 Feb 2013 14:25:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1360700102.git.john@keeping.me.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216208>

John Keeping wrote:

>   Documentation/Makefile: fix inherited {html,info,man}dir

This doesn't seem to have hit the list.

Thanks,
Jonathan
