From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: For review: git add --ignore-unmatch
Date: Thu, 13 Aug 2009 00:57:21 +0200
Message-ID: <200908130057.22646.trast@student.ethz.ch>
References: <200908121726.52121.luke-jr@utopios.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Luke-Jr <luke-jr@utopios.org>
X-From: git-owner@vger.kernel.org Thu Aug 13 00:57:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbMlQ-0004De-Q2
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 00:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbZHLW5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 18:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752769AbZHLW5j
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 18:57:39 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:22365 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752768AbZHLW5i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 18:57:38 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 00:57:38 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Thu, 13 Aug
 2009 00:57:37 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.3.0; x86_64; ; )
In-Reply-To: <200908121726.52121.luke-jr@utopios.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125756>

Luke-Jr wrote:
> 
> [0001-port-ignore-unmatch-from-git-rm-to-git-add.patch]
> [0002-fix-git-add-ignore-errors-to-ignore-pathspec-errors.patch]
> [0003-Document-ignore-unmatch-in-git-add.txt.patch]

I've already told you on IRC how to go about this, so please:

* send one patch per mail, inline
* write real commit messages
* sign off
* write tests

[Yeah, I'm tired and grumpy, but I'm also trying to save others the
work of saying this again more politely...]

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
