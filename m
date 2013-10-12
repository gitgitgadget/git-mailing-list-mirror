From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: My patches
Date: Sat, 12 Oct 2013 17:18:10 +0100
Organization: OPDS
Message-ID: <5247B8D59AAE41F3A0D8BF165D2C2BAE@PhilipOakley>
References: <20131012072450.GA21165@nysa>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Felipe Contreras" <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 12 18:18:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VV1tU-0004kH-L2
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 18:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525Ab3JLQSB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 12:18:01 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:5636 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752244Ab3JLQSA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Oct 2013 12:18:00 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AooGACV1WVJOl3GZ/2dsb2JhbABZgwc4iTm4cgqBGBd0giAFAQEEAQgBAS4eAQEUEgYCAwUCAQMVAQslFAEECBIGBxcGARIIAgECAwGHYwMJCgizYw2JZwSMZII7g1mBBAOFJYNfhhOFEYF0jhMihTaDJTs
X-IPAS-Result: AooGACV1WVJOl3GZ/2dsb2JhbABZgwc4iTm4cgqBGBd0giAFAQEEAQgBAS4eAQEUEgYCAwUCAQMVAQslFAEECBIGBxcGARIIAgECAwGHYwMJCgizYw2JZwSMZII7g1mBBAOFJYNfhhOFEYF0jhMihTaDJTs
X-IronPort-AV: E=Sophos;i="4.93,480,1378854000"; 
   d="scan'208";a="425300817"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip04ir2.opaltelecom.net with SMTP; 12 Oct 2013 17:17:59 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236052>

From: "Felipe Contreras" <felipe.contreras@gmail.com>
Sent: Saturday, October 12, 2013 8:24 AM
> Hi,
>
> Clearly, a lot of my patches have not been reviewed properly, so even
> though they are technically correct, and would benefit users, some 
> have
> specifically been requested by them, and at least one would
> significantly improve Git's user interface...

Hi Filipe,

Given you have put a lot of work into your 16 patch series, is there any 
particular order, or grouping that would help their review.

With so many patches to consider one (the reviewer(s)) gains another 
task of simply trying to prioritise the patches (usually one can take 
big decisions by simply remebering who's series one was interested in).

I expect the clean-ups and 'trivials's' can be managed separately from 
the 'improvements', which would again be separate from the "satging" and 
"Ruby" philosophical discussions.

>   they are going nowhere.
I wouldn't expect 100% success. Every now and again one hears of the 
"here's some patches I've had in my tree for a while" that probably had 
the same early frustrations - they just feel worse the more you produce.

>
> Here is the summary, and you can also find a web version:
> https://github.com/felipec/git/wiki/My-patches
>
> Cheers.
>

Thanks for the summary.
 Philip

> === branch: improve verbose option ===
> Felipe Contreras (2):
> === Reject non-ff pulls by default (v4) ===
> Felipe Contreras (7):
> === remote-helpers: test reorganization (v2) ===
> Felipe Contreras (5):
> === build: add default aliases (v3) ===
> Felipe Contreras (1):
> === Add core.mode configuration (v3) ===
> Felipe Contreras (1):
> === Officially start moving to the term 'staging area' ===
> Felipe Contreras (14):
> === transport-helper: updates (v3) ===
> Felipe Contreras (10):
> === Introduce publish tracking branch ===
> Felipe Contreras (8):
> === New git-related helper (v10) ===
> Felipe Contreras (15):
> === fetch: add new fetch.default configuration ===
> Felipe Contreras (1):
> === Version fixes and cleanups (v4) ===
> Felipe Contreras (2):
> === Trivial paches ===
> Felipe Contreras (20):
> === Massive improvents to rebase and cherry-pick (v6) ===
> Felipe Contreras (28):
> === Support for Ruby (v2) ===
> Felipe Contreras (44):
> === revision: add --except option (v3) ===
> Felipe Contreras (1):
> === sha1-name: refactor get_sha1() parsing ===
> Felipe Contreras (1):
>      sha1-name: refactor get_sha1() parsing
> -- 
> Felipe Contreras
> --
