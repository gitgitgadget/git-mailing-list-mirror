From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: Update German translation.
Date: Tue, 15 Jan 2008 22:54:42 +1100
Message-ID: <18316.40706.103240.308564@cargo.ozlabs.ibm.com>
References: <200801092224.21680.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Tue Jan 15 12:59:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEkSB-0008Rv-Vj
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 12:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbYAOL7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 06:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbYAOL7J
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 06:59:09 -0500
Received: from ozlabs.org ([203.10.76.45]:58306 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901AbYAOL7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 06:59:08 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 8ECE4DDE33; Tue, 15 Jan 2008 22:59:05 +1100 (EST)
In-Reply-To: <200801092224.21680.stimming@tuhh.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70517>

Christian Stimming writes:

> Now 100% complete (163 strings).

I notice you didn't translate the text that is put in the key bindings
help window.  Was that intentional?  Would it perhaps be best to pass
each line of the message through [mc] separately?

Paul.
