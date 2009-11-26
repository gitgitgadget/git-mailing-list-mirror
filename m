From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [egit-dev] Re: jgit problems for file paths with 
 =?iso-8859-1?q?non-ASCII=09characters?=
Date: Thu, 26 Nov 2009 17:44:43 +0100
Message-ID: <200911261744.43917.robin.rosenberg@dewire.com>
References: <4B0D356D.1080709@syntevo.com> <20091126005423.GM11919@spearce.org> <4B0E7DF5.9040007@syntevo.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	EGit developer discussion <egit-dev@eclipse.org>,
	Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 17:44:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDhSf-0002mr-Pf
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 17:44:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbZKZQol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 11:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbZKZQol
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 11:44:41 -0500
Received: from mail.dewire.com ([83.140.172.130]:12016 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739AbZKZQok (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 11:44:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 9F4E680038F;
	Thu, 26 Nov 2009 17:44:45 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I0xXun1M5nsG; Thu, 26 Nov 2009 17:44:45 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id EB84A800378;
	Thu, 26 Nov 2009 17:44:44 +0100 (CET)
User-Agent: KMail/1.11.4 (Linux/2.6.28-11-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <4B0E7DF5.9040007@syntevo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133809>

torsdag 26 november 2009 14:09:09 skrev  Thomas Singer:
> > But as you said, this still doesn't make the Apple normal form
> > any easier.  Though if we know we are on such a strange filesystem
> > we might be able to assume the paths in the repository are equally
> > damaged.  Or not.
>
> Well, if the git-core folks could standardize on, e.g., composed UTF-8
> (rather then just UTF-8), for storing file names in the repository, then
> everything should be clear, isn't it?

Hey, we're trying to enforce composed characters...

-- robin
