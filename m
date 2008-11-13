From: Charles Bailey <charles@hashpling.org>
Subject: git mergetool enhancements
Date: Thu, 13 Nov 2008 12:41:12 +0000
Message-ID: <1226580075-29289-1-git-send-email-charles@hashpling.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Andreas Ericsson <ae@op5.se>, "Theodore Ts'o" <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 13:42:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0bX4-00086U-Gb
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 13:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbYKMMlc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 07:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYKMMla
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 07:41:30 -0500
Received: from ptb-relay03.plus.net ([212.159.14.147]:42864 "EHLO
	ptb-relay03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751943AbYKMMl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 07:41:28 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay03.plus.net with esmtp (Exim) id 1L0bVc-0000O6-Hf; Thu, 13 Nov 2008 12:41:16 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id mADCfFIw029319
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 13 Nov 2008 12:41:15 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id mADCfFd1029318;
	Thu, 13 Nov 2008 12:41:15 GMT
X-Mailer: git-send-email 1.6.0.2.534.g5ab59
X-Plusnet-Relay: 000cb8dfc42ebb9d82fdba8ca2107afd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100870>

Reroll of previously sent mergetool enhancements. Now using -y as the short
option for --no-prompt, but otherwise the same as before.
