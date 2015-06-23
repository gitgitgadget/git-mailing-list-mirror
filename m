From: Jean Audibert <jaudibert@euronext.com>
Subject: Dependency Management
Date: Tue, 23 Jun 2015 08:52:16 +0000
Message-ID: <45DF444C03B59343B5893402DC4F867E3A800EF8@PB2OAEXM01.oad.exch.int>
References: <45DF444C03B59343B5893402DC4F867E3A800EC7@PB2OAEXM01.oad.exch.int>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'git@vger.kernel.org'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 10:52:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Jwa-0003FZ-FT
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 10:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753385AbbFWIwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 04:52:31 -0400
Received: from ukmailgw03.nyx.com ([156.48.57.54]:26749 "EHLO
	ukmailgw03.nyx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbbFWIw3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Jun 2015 04:52:29 -0400
X-IronPort-AV: E=Sophos;i="5.13,664,1427756400"; 
   d="scan'208";a="59335012"
Received: from PB2OAEXM01.oad.exch.int ([fe80::64e9:c35b:8ae:5561]) by
 PB2OAEXC01.oad.exch.int ([::1]) with mapi id 14.03.0210.002; Tue, 23 Jun 2015
 09:52:17 +0100
Thread-Topic: Dependency Management
Thread-Index: AdCtjx50IJjdx59mTziDuZ67pyp7JgAArixA
In-Reply-To: <45DF444C03B59343B5893402DC4F867E3A800EC7@PB2OAEXM01.oad.exch.int>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.79.246.139]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272442>

Hi,

Sorry to bother you with this question but I can't find any "official" answer or "strong opinion" from Git community.

In my company we recently started to use Git and we wonder how to share code and manage dependencies with Git?
Use case: in project P we need to include lib-a and lib-b (libraries shared by several projects)

In your opinion, what is the "future proof" solution?
* Use submodule
* Use subtree

We know there is lot of PRO/CONS but I feel that subtree is "behind" in the race and the latest version of submodule work fine

Suggestions are very welcome.
Thanks in advance,

Jean Audibert


_________________________________________________________________

This message may contain confidential information and is intended for specific recipients unless explicitly noted otherwise. If you have reason to believe you are not an intended recipient of this message, please delete it and notify the sender. This message may not represent the opinion of Euronext N.V. or any of its subsidiaries or affiliates, and does not constitute a contract or guarantee. Unencrypted electronic mail is not secure and the recipient of this message is expected to provide safeguards from viruses and pursue alternate means of communication where privacy or a binding message is desired.
