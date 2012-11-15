From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 7/8] Git.pm: teach "ident" to query explicitness
Date: Thu, 15 Nov 2012 00:13:21 -0800
Message-ID: <20121115081321.GF8429@elie.Belkin>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003628.GG17819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 15 09:13:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYuZw-0004X4-TG
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 09:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992908Ab2KOIN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 03:13:27 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48208 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992722Ab2KOIN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 03:13:26 -0500
Received: by mail-pa0-f46.google.com with SMTP id hz1so912308pad.19
        for <git@vger.kernel.org>; Thu, 15 Nov 2012 00:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p2ntV2tZCBD2fMNHhSM1BGC4d5eSu55YqjimNgMNarM=;
        b=b1foKTtkPIrog/dsK2NvEpvtjhCJEDgWCx3Ge4SGYO4iShgVEU/fPA8hbRv1ICM1Py
         FsYBpyzPdtF2RlM3yBwli4vkRyLjgZelACf83JkBK+2BS8myafrCJq/eqstMSlauaVKs
         ZXCscnrT2Jjj6grF5/ApF3Nm0okSgSj6bSaYicKA70VXoqUph/QgUIzv2cUPZYd+hHBg
         kkja5r6Z3d8W+Qkyo+OIOI+Y///YIJXrhWeKRfnWqhqr9c94gdihknRb2Gk4NUq4iqn9
         URV3/fZnCnkeRuOAMZHgZT3bQuo5INFn2v3cZUCCicLFu14/hm4iYFMj4sHAGOe7Vb3l
         5QWA==
Received: by 10.68.229.194 with SMTP id ss2mr2503484pbc.17.1352967206491;
        Thu, 15 Nov 2012 00:13:26 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id f2sm9351990paz.25.2012.11.15.00.13.24
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Nov 2012 00:13:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121115003628.GG17819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209807>

Jeff King wrote:

> Signed-off-by: Jeff King <peff@peff.net>

For what it's worth,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
