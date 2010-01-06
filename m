From: Miles Bader <miles@gnu.org>
Subject: Re: cmake, was Re: submodules' shortcomings
Date: Wed, 06 Jan 2010 13:25:18 +0900
Message-ID: <buovdffoo5t.fsf@dhlpc061.dev.necel.com>
References: <4B3F6742.6060402@web.de>
	<alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
	<4B421F90.4090402@web.de>
	<alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
	<3af572ac1001051238t63e07a25hf9dd77056b79be89@mail.gmail.com>
	<alpine.DEB.1.00.1001060005010.4985@pacific.mpi-cbg.de>
	<3af572ac1001051717u7757f0dep9392fbb7b02cbbca@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Wed Jan 06 05:25:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSNSe-00006L-3Q
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 05:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068Ab0AFEZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 23:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774Ab0AFEZ2
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 23:25:28 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:47416 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab0AFEZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 23:25:27 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id o064PEBV009339;
	Wed, 6 Jan 2010 13:25:18 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.16] [10.29.19.16]) by relay11.aps.necel.com with ESMTP; Wed, 6 Jan 2010 13:25:18 +0900
Received: from dhlpc061 ([10.114.114.32] [10.114.114.32]) by relay11.aps.necel.com with ESMTP; Wed, 6 Jan 2010 13:25:18 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id 7C57F52E1EF; Wed,  6 Jan 2010 13:25:18 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <3af572ac1001051717u7757f0dep9392fbb7b02cbbca@mail.gmail.com>
	(Pau Garcia i. Quiles's message of "Wed, 6 Jan 2010 02:17:45 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136240>

Pau Garcia i Quiles <pgquiles@elpauer.org> writes:
> At this moment, what stops me from beginning this project is a simple
> question: is it worth my time? From the discussion a few months ago,
> it looked like it would the a second-class citizen and never replace
> the existing buildsystems, so I really wonder if I should spend me
> time porting git to CMake, or I should focus on other projects which
> would gladly receive my contributions. If you honestly think it's
> worth it, just tell me and I'll start the port to CMake immediately.

It sounds like it's you who want it, so aren't you the best person to
make that judgement...?  It seems very unlikely for cmake to replace
anything.

-Miles

-- 
Politeness, n. The most acceptable hypocrisy.
