From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: ambiguous git-log date and timestamp syntax
Date: Sun, 02 Mar 2008 08:09:58 +0100
Message-ID: <87skz91u0p.fsf@mid.deneb.enyo.de>
References: <715587AA-D485-4B31-A786-D26334506007@gmail.com>
	<m3d4qejroy.fsf@localhost.localdomain>
	<alpine.LFD.1.00.0803011010480.17889@woody.linux-foundation.org>
	<200803012326.05698.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 08:11:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JViLf-0006aW-3i
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbYCBHKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYCBHKB
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:10:01 -0500
Received: from mail.enyo.de ([212.9.189.167]:36894 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbYCBHKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:10:01 -0500
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1JViKd-0001ot-DT
	for git@vger.kernel.org; Sun, 02 Mar 2008 08:09:59 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1JViKc-0001qA-Sg
	for git@vger.kernel.org; Sun, 02 Mar 2008 08:09:58 +0100
In-Reply-To: <200803012326.05698.jnareb@gmail.com> (Jakub Narebski's message
	of "Sat, 1 Mar 2008 23:26:04 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75734>

* Jakub Narebski:

> I wonder how it compares with GNU date (from GNU Corutils) inexact date
> parsing (and why we couldn't lift the code from GNU date)...

I think the licenses are incompatible, you can't link that code to
OpenSSL.
