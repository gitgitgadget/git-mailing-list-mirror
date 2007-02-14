From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [ANNOUNCE] GIT 1.5.0
Date: Wed, 14 Feb 2007 09:06:35 +0000
Message-ID: <200702140906.37440.andyparkins@gmail.com>
References: <7vlkj1v3av.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 14 10:06:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHG6D-0004CK-QP
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 10:06:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbXBNJGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 04:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbXBNJGq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 04:06:46 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:46748 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbXBNJGo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 04:06:44 -0500
Received: by ug-out-1314.google.com with SMTP id 44so114956uga
        for <git@vger.kernel.org>; Wed, 14 Feb 2007 01:06:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=QBtLHtU40E6ZB+v5Et2De59DvBfqCQ9hzoIt1XJc5d5zOO50gMUYArp/tvQ3R6MT1Oi5v6ly/BQ9PLrlyUoxwjfKcz6xEmBf1Xs9INPCsocRAI8s5ZycnwT4hfmUTIRel4VF8OfDWYFDvr+WsCHAExPlGunmHUMTpWLjIrO+2H8=
Received: by 10.67.119.13 with SMTP id w13mr144531ugm.1171444003310;
        Wed, 14 Feb 2007 01:06:43 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id 24sm559036ugf.2007.02.14.01.06.39;
        Wed, 14 Feb 2007 01:06:41 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vlkj1v3av.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39624>

On Wednesday 2007 February 14 03:14, Junio C Hamano wrote:

>  - There is a configuration variable core.legacyheaders that

> The above two are not enabled by default and you explicitly have
> to ask for them, because these two features make repositories

It isn't really the case that you have to _enable_ legacyheaders?  It defaults 
to on already.  You actually have to disable legacyheaders.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
