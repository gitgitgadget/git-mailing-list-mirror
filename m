From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git cheat sheet
Date: Wed, 29 Aug 2007 12:04:07 +0200
Message-ID: <20070829100407.GA28853@diana.vm.bytemark.co.uk>
References: <200708290348.02853.zack@kde.org> <7vfy22squc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zack Rusin <zack@kde.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 12:05:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQKQ2-0001lu-3E
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 12:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761AbXH2KE7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Aug 2007 06:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755822AbXH2KE6
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 06:04:58 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4694 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755590AbXH2KE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 06:04:58 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IQKP9-0007cC-00; Wed, 29 Aug 2007 11:04:07 +0100
Content-Disposition: inline
In-Reply-To: <7vfy22squc.fsf@gitster.siamese.dyndns.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56926>

On 2007-08-29 01:11:07 -0700, Junio C Hamano wrote:

> - "git reset --hard HEAD"; you do not have to write HEAD there.

There should also probably be a warning about any local changes being
irretrievably lost. (The existing warning is kind of vague.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
