From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Git Wiki improvements
Date: Mon, 14 Apr 2008 10:06:41 +0200
Message-ID: <8aa486160804140106m570d3fb9va0081d8a0d42870@mail.gmail.com>
References: <60CC37BF5A3B73428D0BB9B6A26B9669019D95DA@yvrmail1.corp.navcan.ca>
	 <200804140303.22624.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pack, Dylan" <PackD@navcanada.ca>,
	"Pack, Dylan" <sarpulhu@gmail.com>, git@vger.kernel.org,
	"Petr Baudis" <pasky@suse.cz>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 10:08:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJiq-0008AY-3Y
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 10:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757601AbYDNIGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 04:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755709AbYDNIGn
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 04:06:43 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:16545 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756823AbYDNIGl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 04:06:41 -0400
Received: by yw-out-2324.google.com with SMTP id 5so607517ywb.1
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RB5x3CBzGUmpDuO8mUwer/f/cU0980kpzJQs/nzgq2U=;
        b=SNjZedRUoWjHxZRv0wSzcSluPjjvWgn3zpTT5JbkDnghLrjdk0b9blH/ef4aV51zb+T05WFJ5DjI7kRmWZeRA1/vCQ2dpIHZpWaCEKVhFckymheBVUPBQIhFSryPzvkFvmZcV/mmwvk8e2Hn+LA4l6P6z8HotvXClAnzVM/Eyhs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CGmMGD3zCdT26MkIkdAxKc4dolX8nQ4gfOCboqnctUXhKMboCDhmC/63+SGB/hjQywHEbbdzsc42HHPuceoYeE3/cb+ZJWBzlPE/q4cMhR+WN5AYsxWru9Q5p+TYNX53Cj9ZLWELlfWHgrbOjf4knn42/j9H/w8RxwfqVTbrHEw=
Received: by 10.150.133.18 with SMTP id g18mr5754110ybd.74.1208160401078;
        Mon, 14 Apr 2008 01:06:41 -0700 (PDT)
Received: by 10.151.14.14 with HTTP; Mon, 14 Apr 2008 01:06:41 -0700 (PDT)
In-Reply-To: <200804140303.22624.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79488>

Maybe we could switch to a wiki with git support (it solves the
problem because there is no GUI, jeje), for example ikiwiki. This way
you can edit the pages from the web and from git. Some time ago I told
it to Petr and he answered me "but I'd prefer you to discuss this at
git@". I didn't because I didn't find an "easy" way to convert
MoinMoin to Markdown (used by default in ikiwiki, but can can be
others via plugins), but maybe others know!

Santi
