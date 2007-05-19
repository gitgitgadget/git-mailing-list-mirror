From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/5] Metadata format versioning
Date: Sat, 19 May 2007 02:09:46 +0200
Message-ID: <20070519000451.4906.87089.stgit@yoghurt>
References: <20070516062711.GA7235@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:10:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpCWK-0002GJ-0i
	for gcvg-git@gmane.org; Sat, 19 May 2007 02:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102AbXESAJ4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 20:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbXESAJ4
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 20:09:56 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:59763 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754102AbXESAJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2007 20:09:56 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:54505 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HpCWA-000234-7L; Sat, 19 May 2007 02:09:54 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HpCW2-0001Jv-KV; Sat, 19 May 2007 02:09:46 +0200
In-Reply-To: <20070516062711.GA7235@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HpCWA-000234-7L.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HpCWA-000234-7L c46f36a59b7277cfc8d815867b708094
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47685>

On 2007-05-16 08:27:11 +0200, Karl Hasselstr=C3=B6m wrote:

> I'll probably have time to whip up a patch later today.

OK, so this turned out to be a slight miscalculation. But here it is,
with a test! The test contains two small tarballs, so I had to whip up
binary patch support as well.

> I'll make a single version bump for the format changes you've alreay
> applied, and re-do the format-changing patches you haven't applied
> yet so that they have version bumping integrated.

This contains a single version bump (1 -> 2) for the applied changes,
but i haven't updated the DAG patch to use this yet. That's for
another day.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
