From: Wilbert van Dolleweerd <wilbert@arentheym.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Tue, 23 Nov 2010 21:10:40 +0100
Message-ID: <AANLkTik=s7dxFRTRZdjJD3pLtzRLPT_HwMCR5VWCNKCg@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
	<AANLkTikXkWvHrc7=FjePfX5WyyNF1U=KH2DBCU+CcVu6@mail.gmail.com>
	<AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git ML <git@vger.kernel.org>
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 21:10:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKzCV-0005sV-2b
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 21:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab0KWUKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 15:10:42 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48870 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab0KWUKl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 15:10:41 -0500
Received: by gyb11 with SMTP id 11so2301410gyb.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 12:10:41 -0800 (PST)
Received: by 10.100.109.8 with SMTP id h8mr5359039anc.106.1290543040791; Tue,
 23 Nov 2010 12:10:40 -0800 (PST)
Received: by 10.100.121.6 with HTTP; Tue, 23 Nov 2010 12:10:40 -0800 (PST)
X-Originating-IP: [82.171.76.203]
In-Reply-To: <AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162020>

2010/11/23 Dun Peal <dunpealer@gmail.com>:

> On Tue, Nov 23, 2010 at 7:12 PM, Wilbert van Dolleweerd
> <wilbert@arentheym.com> wrote:
>> How big is your repository? We're using some fairly big repositories
>> over here but I haven't seen this behavior with the latest version of
>> msysgit.
>
> The working copy totals about 4GB. The .git directory, tightly packed, is 1GB.

I'll see what size our largest repository is at my company first thing
in the morning.

kind regards,

Wilbert van Dolleweerd
Blog: http://walkingthestack.wordpress.com/
Twitter: http://www.twitter.com/wvandolleweerd
