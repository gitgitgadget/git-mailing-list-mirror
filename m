From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: stg branch command failures.
Date: Wed, 10 Oct 2007 09:34:57 +0200
Message-ID: <20071010073457.GA12970@diana.vm.bytemark.co.uk>
References: <cc723f590710092031w87511dfl6ee3b728375f0815@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, catalin.marinas@gmail.com
To: Aneesh Kumar <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 09:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfW6G-0007xW-8u
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 09:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752480AbXJJHfM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2007 03:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbXJJHfM
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 03:35:12 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4841 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbXJJHfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 03:35:11 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IfW5p-0003Oq-00; Wed, 10 Oct 2007 08:34:57 +0100
Content-Disposition: inline
In-Reply-To: <cc723f590710092031w87511dfl6ee3b728375f0815@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60473>

On 2007-10-10 09:01:22 +0530, Aneesh Kumar wrote:

> Both the below commands doesn't work
>
> stg branch --rename review test-large-file
> stg branch -c review v2.6.23-rc9
>
> It throws error
> fatal: Needed a single revision

It works for me, in the kha/experimental branch. And I suspect it also
works with kha/safe, since safe..experimental doesn't seem to contain
anything relevant to this. What version are you using?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
