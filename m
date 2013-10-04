From: Thomas Koch <thomas@koch.ro>
Subject: Re: Git counterpart to SVN bugtraq properties?
Date: Fri, 4 Oct 2013 11:15:52 +0200
Message-ID: <201310041115.52948.thomas@koch.ro>
References: <51E69612.6020201@syntevo.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Fri Oct 04 11:16:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS1UP-0000Q4-F7
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 11:16:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202Ab3JDJP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 05:15:57 -0400
Received: from koch.ro ([88.198.2.104]:40877 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861Ab3JDJP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 05:15:56 -0400
Received: from 44-25.106-92.cust.bluewin.ch ([92.106.25.44] helo=x121eofhwr1202.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1VS1UI-0005Pe-Cl; Fri, 04 Oct 2013 11:15:54 +0200
User-Agent: KMail/1.13.7 (Linux/3.10-0.bpo.3-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <51E69612.6020201@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235706>

On Wednesday, July 17, 2013 03:03:14 PM Marc Strapetz wrote:
> I'm looking for a specification or guidelines on how a Git client should
> integrate with bug tracking systems. For SVN, one can use
> bugtraq-properties [1] to specify e.g. the issue tracker URL ...

There's seldom a question that has not been asked before. There already is a 
popular standard for project information like the link to a bugtracker and 
much more: https://en.wikipedia.org/wiki/DOAP (Description of a Project) 
