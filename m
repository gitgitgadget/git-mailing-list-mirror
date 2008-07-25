From: =?ISO-8859-1?Q?Peter_Valdemar_M=F8rch?= <lists@morch.com>
Subject: Re: [PATCH] Document disabling core.whitespace values trailing-space
 and space-before-tab
Date: Fri, 25 Jul 2008 08:11:49 +0200
Message-ID: <48896EA5.1090608@morch.com>
References: <4888144E.8090300@sneakemail.com> <20080724172912.6117@nanako3.lavabit.com> <7vbq0m608w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 08:12:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMGXt-0005mZ-9R
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 08:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbYGYGLx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 02:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbYGYGLx
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 02:11:53 -0400
Received: from morch.com ([193.58.255.207]:53542 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750943AbYGYGLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 02:11:52 -0400
Received: from [192.168.1.214] (ANice-157-1-37-217.w90-28.abo.wanadoo.fr [90.28.176.217])
	by morch.com (Postfix) with ESMTP id 74C42281D
	for <git@vger.kernel.org>; Fri, 25 Jul 2008 08:13:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080502)
In-Reply-To: <7vbq0m608w.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90004>

> So I think Peter's patch is going in the right direction.

Thus encouraged, I've created a file with two more patches like I=20
described in my previous mail: one that fixes up .gitattributes and one=
=20
that fixes up t/* to conform to documented syntax of core.whitespace.

(For the future: Is it better to have one file with tree patches like I=
=20
have created with git format-patch -M -s --stdout, 3 individual numbere=
d=20
files, or one single patch created with git-merge --squash?)

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
