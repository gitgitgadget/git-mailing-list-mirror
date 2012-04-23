From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/10] i18n: help: mark strings for translation
Date: Mon, 23 Apr 2012 13:34:39 -0500
Message-ID: <20120423183439.GA12916@burratino>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <1335184230-8870-5-git-send-email-pclouds@gmail.com>
 <20120423163032.GF4832@burratino>
 <xmqqaa22jor5.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:34:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMO6E-0003QJ-CX
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 20:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab2DWSey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 14:34:54 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63945 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab2DWSex (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 14:34:53 -0400
Received: by iadi9 with SMTP id i9so2350094iad.19
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 11:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dW9TSwBNLnOl3flNp7ARp4To1Ej0qUc8/g+l6sDuqpA=;
        b=jDObo5Xm2Uk4s7MLME3bNeTKpsoz+stRFpJDjkgx+LIGXeHvmTeFxccXqb/7YdQdwr
         bxW6aoNdCXCrjXSri7zOot9HOlOiZvtMOZxiJyRvl5qH+TWEai9GIHO6mDFnIiyuyI+r
         M28PzAu7ElUye1Uw43W2FFB94dHz4Vssw/Zm7VlhbyfX+hx66dZ3D99J3sEaORFnMJ7D
         BD9iknpHv/z114PqK+y1QVCt7HQdD0VeCHNA2Fbomb4xa767LYNeii+cCQWAXLe3J5OT
         SIS87HL+seq1c5shYZdunKOMsjBeB9CaY7cFN43ipVW5TGIuc4gzRmzDWH9Fu7xAhG5g
         AYTA==
Received: by 10.42.159.202 with SMTP id m10mr12299118icx.50.1335206092533;
        Mon, 23 Apr 2012 11:34:52 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id gs4sm27423230igc.8.2012.04.23.11.34.47
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Apr 2012 11:34:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqaa22jor5.fsf@junio.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196156>

Junio C Hamano wrote:

>                                                        Wouldn't a simple
> and clean "blank line" look better?

Yes, based on a quick test with "vi" it looks reasonable.  Thanks for
a sanity check.
