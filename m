From: Christian Couder <christian.couder@gmail.com>
Subject: Promoting Git developers (was: Bashing freelancers)
Date: Sat, 7 Mar 2015 08:18:37 +0100
Message-ID: <CAP8UFD1+rC0FjisSddDcyn1E_75wtBU9pEpUcQX5zNtd4zKYFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: David Kastrup <dak@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 08:19:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU915-0004ks-9G
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 08:19:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754921AbbCGHSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2015 02:18:38 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:41590 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498AbbCGHSi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 02:18:38 -0500
Received: by iecrl12 with SMTP id rl12so8472009iec.8
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 23:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HQX4FIi1oBg0t2JUZIX4LhRqaAFnMv1Ao/evPwLhdcw=;
        b=z6cDfY+ZEIdaSQRRUVg6Aes6+hKMOe5+MdLGAIquzi8lXli26jViwKDrZBkleiFFhc
         miNJSUB2bqkLOWDow8KEADwIrxcBpu5cZFKlVyZKJLvIF5T2muebVjeuMztsNfu3uaaz
         jto8iRV0/vgV1ZNhzQW8N3kHc7HEkpZ/YRDZlPzPU1/ty+nT1790dbCCO8aIywUtGcZE
         6sDNhOVORO2Z8LuYUmVSgXkZwnJHVzf4PAMDGm4OpSPCJ18+FQ+oZ6AljHaahWHcVq3i
         SUDdE00aR53NfKBcBwodi1KTHCe1bQLFXVAu2lhaH2TxMlsyruwmGFcobwrx/roSweZV
         rhDg==
X-Received: by 10.50.253.12 with SMTP id zw12mr59046453igc.24.1425712717311;
 Fri, 06 Mar 2015 23:18:37 -0800 (PST)
Received: by 10.50.245.144 with HTTP; Fri, 6 Mar 2015 23:18:37 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264993>

Hi,

On Fri, Mar 6, 2015 at 6:41 PM, David Kastrup <dak@gnu.org> wrote:

> At some point of time I think it may be worth reevaluating the toxic
> atmosphere against freelancers doing Git development.

My opinion on this is that the Git community has not been good
especially lately at promoting its own developers.

Some facts:

* There used to be an AUTHORS section in each of the git man page.
They have been removed. The rational was that they were hard to
maintain and the information about authors was easily available
elsewhere.

* There used to be a nice page on git-scm.com, the main Git web site,
listing the authors and how many commits they had contributed. It has
been removed.

* In the "A note from the maintainer" emails that Junio regularly
sends, the last section about "Other people's trees, trusted
lieutenants and credits." seems to have been truncated for some time
and doesn't show anymore the nice "credits" words it used to show.
Maybe this is a bug.

* https://www.openhub.net/p/git/contributors/summary seems to give me a
"504 Gateway Time-out" right now :-(

* On the Git Merge web site, we can see that none of the speakers
seems to have been a very active contributor to git.git

None of these facts is a big issue in itself for me, but I think the
trend is very sad, and I would be happy if we could discuss here or at
the Git Merge (or both) about ways to improve in this area.

Best,
Christian.
