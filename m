From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cvs-fast-export release announcement
Date: Sun, 13 Jan 2013 22:28:54 -0800
Message-ID: <20130114062854.GF3125@elie.Belkin>
References: <20130114001300.57D3640661@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, vcs-fast-import-devs@lists.launchpad.net,
	Johan Herland <johan@herland.net>
To: "Eric S. Raymond" <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 07:29:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TudXw-0004fW-Dt
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 07:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752925Ab3ANG3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 01:29:00 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58639 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab3ANG27 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 01:28:59 -0500
Received: by mail-pa0-f54.google.com with SMTP id bi5so2065355pad.41
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 22:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=FpbM5l0nFZEiwAaZX31+6g83xijYBN9Ns2tnDSL78HI=;
        b=w5TR/90hw+xNC9BgncjKvOackNYi6lGWPpQIjQ3Lmby7MxsBrYEIvXLoTFOJTXxfy3
         VaKZAfJiNQgjCitcQ58T6SEnzQM3ac4/EmP8sjLQV1/51J3vaZI/7GFEJlk2u12Do7sN
         ngRiRFtYf/s21HhKsbu54f1aisKZdBb3bCnTaBakXzzYPHmQoPqnbL2Ol/1RsITTCasC
         NVykDPCmPu4ktvlvpmudNKLqNgoPK5wBbXvpeEyH7TtM9PxBRIlGCByB7bxCZ+nSbQIr
         dcngBa3eDUJgOOHxTInfpsZAbyz2jRZPhffw5zRkfLmCWez5ecDgx/KsF2hc/5sUhPB7
         JBJw==
X-Received: by 10.66.90.1 with SMTP id bs1mr229716550pab.19.1358144939290;
        Sun, 13 Jan 2013 22:28:59 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id a4sm8163755paw.21.2013.01.13.22.28.57
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 22:28:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130114001300.57D3640661@snark.thyrsus.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213452>

Eric S. Raymond wrote:

> cvs-fast-export.  Project page, with links to documentation and the
> public repository, is at <http://www.catb.org/esr/cvs-fast-export/>.

Yay, thanks for building this.
