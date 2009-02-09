From: Federico Mena Quintero <federico@novell.com>
Subject: Re: [PATCH] rpm2git (was RPM to GIT tree integration?)
Date: Mon, 09 Feb 2009 15:14:10 -0600
Message-ID: <1234214050.328.567.camel@cacharro.xalalinux.org>
References: <b2cdc9f30902080851j724e9fa9s35ff159b775ad614@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 22:15:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdTS-0001mh-CJ
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 22:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbZBIVN7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 16:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbZBIVN6
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 16:13:58 -0500
Received: from charybdis-ext.suse.de ([195.135.221.2]:50710 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752106AbZBIVN6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 16:13:58 -0500
Received: from [192.168.1.102] ([149.44.162.75])
	by emea5-mh.id5.novell.com with ESMTP (TLS encrypted); Mon, 09 Feb 2009 22:13:54 +0100
In-Reply-To: <b2cdc9f30902080851j724e9fa9s35ff159b775ad614@mail.gmail.com>
X-Mailer: Evolution 2.22.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109132>

On Sun, 2009-02-08 at 16:51 +0000, Alex Bennee wrote:

> Pretty much what I wanted although the script breaks on fancy SPEC's
> that use variables to evaluate version (like Fedora Core's kernel).
> The attached patch allows the specification of the branch by hand.
> CC'd to federico.

Very nice, thanks!  I just pushed this to gitorious, with a few
stylistic changes.

  Federico
