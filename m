From: =?ISO-8859-1?Q?Tor_Arne_Vestb=F8?= <torarnv@gmail.com>
Subject: Re: [EGIT PATCH 00/11] Support customizable label decorations
Date: Thu, 05 Feb 2009 02:04:27 +0100
Message-ID: <498A3B1B.3000600@gmail.com>
References: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 02:07:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUshv-0002D4-EL
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 02:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758202AbZBEBEf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 20:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756710AbZBEBEe
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 20:04:34 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:6721 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135AbZBEBEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 20:04:33 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2483fgg.17
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 17:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=eOITwzXCh/n657N8gEoiRPtdFtFJyaeYRtAGQ4+bJg0=;
        b=NokzMTSoHg4YDF6hRdD32kDQfDYAbkTX24ho5OxwpRx9phSfIx6uWiPm5go69uqF1U
         8dWsEUmTVtDbuswTJjPgnb1G8RpTLRhROXy4YEWrW+YkC41z9qjETgG2fGWA0Gym8+uh
         ePv93BwBrZTPFeknAwInfMBNeiX0RreWVJ83g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=k88TR0/tePXTj7M0NaVhnC9hqpVfvkV1SEi3xLKlZnAaYo9t7cE1CpmOHSADMfcfts
         q/NIywhipsQcG6IQ5KmX68LkheKUGYN0s//RNaghS9l62t1afDPDvQU0RnWB6rLkVxyP
         ueVkhglOYSUQWtysbPSzLcnDKsdtwZQzV/WCo=
Received: by 10.86.95.20 with SMTP id s20mr6740fgb.4.1233795871697;
        Wed, 04 Feb 2009 17:04:31 -0800 (PST)
Received: from ?192.168.1.226? (212251244070.customer.cdi.no [212.251.244.70])
        by mx.google.com with ESMTPS id e20sm22488fga.46.2009.02.04.17.04.30
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Feb 2009 17:04:31 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <1233795618-20249-1-git-send-email-torarnv@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108489>

Tor Arne Vestb=F8 wrote:
> This series adds support for customizable label decorations, which
> is usefull for hiding selected decorations, or tweaking the format
> of the decoration text.

Oh, I forgot, the branch can be found here:

http://repo.or.cz/w/egit/torarne.git?a=3Dshortlog;h=3Drefs/heads/custom=
izable-decorations

Tor Arne
