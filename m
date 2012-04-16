From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] Add details about svn-fe's dumpfile parsing
Date: Mon, 16 Apr 2012 17:27:00 -0500
Message-ID: <20120416222700.GT12613@burratino>
References: <4F8AF306.8070804@pileofstuff.org>
 <7vipgztpaf.fsf@alter.siamese.dyndns.org>
 <4F8C909B.7010507@pileofstuff.org>
 <20120416213910.GP12613@burratino>
 <4F8C9A13.80906@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:27:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuOD-0002gQ-CO
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755220Ab2DPW1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:27:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51177 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab2DPW1L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 18:27:11 -0400
Received: by iagz16 with SMTP id z16so8027632iag.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=978JNF3mSfxKJKb5zQbwT7v01tynEI/zISjpRVrYYqc=;
        b=VczeiILT7b72wQ8WbHc7njvhL9Coau03n7fnG3jo8AI14e8y2ErlaYBY+tMh6bCEIC
         UsLqwTUkhQYj6kaTKnuRFvIXHW6aEy7etwBBsHuZWJ7w92EhEXt7gbp7QRJk8c0ILudr
         bbMFl/iUZXgnqcATacULPm/M0l9S1SUnNBVz54LyNPQmHYk30P1rPpbu1hFsSDvoHEwa
         Sm2CLyq7Urms0ngrgWQ+H//tkYQadC7LS0CCehwnj5wGLH1M9BxuCMIxcE35Cs2MLdNd
         r7tOg1Fmp+6fqzFEzwAwJzFjKyQF9qoNX5NQVqEuCjTK6/Pzumy2ULZ/TjfUkyb2ivri
         UXhw==
Received: by 10.50.189.129 with SMTP id gi1mr7335676igc.16.1334615230881;
        Mon, 16 Apr 2012 15:27:10 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ew6sm10604738igc.6.2012.04.16.15.27.08
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 15:27:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F8C9A13.80906@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195714>

Andrew Sayers wrote:

>                                                                   Like
> HTML5, I figure I've got to take the argument to the official body some
> day, but I'd rather have something vaguely mature first.

Perhaps unlike the XHTML days at the W3C ;-), in this instance the
people responsible for the dump-load-format.txt document are really
nice and helpful and generally right-minded people.

If the mailing list is intimidating (or even if not), I'd recommend
visiting the IRC channel #svn-dev on freenode to say hello and get
advice.

Jonathan
