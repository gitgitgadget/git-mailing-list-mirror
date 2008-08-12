From: Thomas Koch <thomas@koch.ro>
Subject: fastest way to check if dir is a workdir
Date: Tue, 12 Aug 2008 13:34:56 +0200
Organization: Young Media Concepts
Message-ID: <200808121334.57066.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 13:36:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSsBH-0002Df-CC
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 13:36:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbYHLLfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 07:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbYHLLfs
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 07:35:48 -0400
Received: from koch.ro ([195.34.83.107]:60900 "EHLO
	ve825703057.providerbox.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750958AbYHLLfs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Aug 2008 07:35:48 -0400
Received: from 217-162-251-183.dclient.hispeed.ch ([217.162.251.183] helo=jona.local)
	by ve825703057.providerbox.net with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <thomas@koch.ro>)
	id 1KSs9j-0007pq-9S
	for git@vger.kernel.org; Tue, 12 Aug 2008 13:35:17 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Spam_score: -2.3
X-Spam_score_int: -22
X-Spam_bar: --
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92087>

Hi,

I'm writing a little php-git-wrapper and would like to have a function
which tells me, whether a given path is part of a git checkout or not.

What would be the fastest commandline to check, whether the current dir
is part of a checkout? It may be assumed that the repository is at the
standard position.

Thanks a lot,
-- 
Thomas Koch, Software Developer
http://www.koch.ro

Young Media Concepts GmbH
Sonnenstr. 4
CH-8280 Kreuzlingen
Switzerland

Tel    +41 (0)71 / 508 24 86
Fax    +41 (0)71 / 560 53 89
Mobile +49 (0)170 / 753 89 16
Web    www.ymc.ch
