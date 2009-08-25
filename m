From: Fritz Anderson <fritza@uchicago.edu>
Subject: Re: Confused about push/pull of a branch
Date: Tue, 25 Aug 2009 13:00:24 -0500
Message-ID: <F7D4EAF0-68C9-4A88-86D4-75FD3B71F015@uchicago.edu>
References: <BA2E0DDB-3DE0-4D49-BFA6-72CFEDEBA5AE@uchicago.edu> <8E2E19AE-DFA6-4000-AD73-35739F1E6642@uchicago.edu>
Mime-Version: 1.0 (Apple Message framework v1075.2)
Content-Type: text/plain; charset=windows-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 25 20:00:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg0Jt-0000Gj-AM
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 20:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbZHYSAX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2009 14:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524AbZHYSAX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 14:00:23 -0400
Received: from authsmtp00.uchicago.edu ([128.135.249.245]:49578 "EHLO
	authsmtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517AbZHYSAX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Aug 2009 14:00:23 -0400
Received: from fritzanderson.uchicago.edu (fritzanderson.uchicago.edu [128.135.0.17])
	(authenticated bits=0)
	by authsmtp00.uchicago.edu (8.13.1/8.13.1) with ESMTP id n7PI0Q0m006637
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Tue, 25 Aug 2009 13:00:26 -0500
In-Reply-To: <8E2E19AE-DFA6-4000-AD73-35739F1E6642@uchicago.edu>
X-Mailer: Apple Mail (2.1075.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127036>

On Aug 25, 2009, at 12:58 PM, Fritz Anderson wrote:

> This seems to mean that master on machine_2 is now congruent to =20
> webservices on machine_1. That's not what I meant. Is there a way to =
=20
> undo this? git-pull origin-master doesn't seem to do anything.

Sigh. "git pull origin master". Sorry.

	=97 F
