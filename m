From: "Yakup Akbay" <yakbay@ubicom.com>
Subject: RE: Feature Request: Capability to save and load the workspace
Date: Fri, 31 Jul 2009 02:16:58 -0700
Message-ID: <CB2DD11991B27C4F99935E6229450D3204837B8F@STORK.scenix.com>
References: <4A72AF1C.1020500@ubicom.com> <40aa078e0907310209p458cf912r1eb4329a409cefa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: "Erik Faye-Lund" <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 11:18:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWoG3-0005vz-Sr
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 11:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbZGaJS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 05:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbZGaJS2
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 05:18:28 -0400
Received: from server70.appriver.com ([69.20.119.203]:4471 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbZGaJS2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Jul 2009 05:18:28 -0400
X-Policy: GLOBAL - ubicom.com
X-Policy: GLOBAL - ubicom.com
X-Primary: yakbay@ubicom.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: TCH-CT/SI:0-44/SG:2 7/31/2009 5:17:11 AM
X-GBUdb-Analysis: 0, 216.112.109.98, Ugly c=0.659548 p=-0.833887 Source Normal
X-Signature-Violations: 0-0-0-2931-c
X-Note: Spam Tests Failed: 
X-Country-Path: UNITED STATES->UNITED STATES
X-Note-Sending-IP: 216.112.109.98
X-Note-Reverse-DNS: 216.112.109.98.ptr.us.xo.net
X-Note-WHTLIST: yakbay@ubicom.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 114 115 116 117 121 122 217 
X-Note: Mail Class: VALID
X-Note: Headers Injected
Received: from [216.112.109.98] (HELO stork.scenix.com)
  by server70.appriver.com (CommuniGate Pro SMTP 5.2.14)
  with ESMTP id 100393170; Fri, 31 Jul 2009 05:17:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <40aa078e0907310209p458cf912r1eb4329a409cefa7@mail.gmail.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Feature Request: Capability to save and load the workspace
Thread-Index: AcoRvmfYWWIuz/mCSnOJ1UiaauakLwAAMNRg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124516>

AFAIK, git-stash does not save untracked and ignored files. What I need
is to save them, too.

But yes, git-stash could be a good candidate for this.

Yakup

-----Original Message-----
From: Erik Faye-Lund [mailto:kusmabite@googlemail.com] 
Sent: Freitag, 31. Juli 2009 12:10
To: Yakup Akbay
Cc: git@vger.kernel.org
Subject: Re: Feature Request: Capability to save and load the workspace

On Fri, Jul 31, 2009 at 10:45 AM, Yakup Akbay<yakbay@ubicom.com> wrote:
> IT WOULD BE NICE to have a feature in git that allows us to save the
> current workspace then work on a different profile on a clean
> environment. Then save that profile and switch back to the previous
> profile at any time without losing the environment.

Did you have a look at the stash command yet? I might be missing
something, but it looks to me like it's exactly what you're looking
for...

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
