From: Jan =?UTF-8?B?S3LDvGdlcg==?= <jk@jk.gs>
Subject: Re: [PATCH] pull: clarify advice for the unconfigured error case
Date: Thu, 3 Dec 2009 11:51:10 +0100
Message-ID: <20091203115110.08dde406@perceptron>
References: <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
	<1257965806.26362.132.camel@heerbeest>
	<D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
	<1257968052.26362.155.camel@heerbeest>
	<AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
	<1258035449.26362.273.camel@heerbeest>
	<20091112155310.7836c388@perceptron>
	<20091112150626.GA24848@coredump.intra.peff.net>
	<20091112170814.1858aba4@perceptron>
	<20091113040754.GA3255@progeny.tock>
	<20091127141704.GA24080@progeny.tock>
	<7vk4x57z4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 11:51:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG9Hq-00023E-HM
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 11:51:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754452AbZLCKvi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 05:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbZLCKvi
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 05:51:38 -0500
Received: from zoidberg.org ([88.198.6.61]:33202 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbZLCKvh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 05:51:37 -0500
Received: from perceptron (pC19EAB10.dip.t-dialin.net [::ffff:193.158.171.16])
  (AUTH: LOGIN jast, TLS: TLSv1/SSLv3,128bits,AES128-SHA)
  by cthulhu.zoidberg.org with esmtp; Thu, 03 Dec 2009 11:51:41 +0100
  id 004D0355.4B17983E.00007E5B
In-Reply-To: <7vk4x57z4e.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.3 (GTK+ 2.18.3; i486-pc-linux-gnu)
X-Obscure-Spam: http://music-jk.net/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134447>

Junio C Hamano <gitster@pobox.com> wrote:

> Is this a good replacement for 31971b3 (git-pull.sh --rebase: overhaul
> error handling when no candidates are found, 2009-11-12) that is on
> 'pu' and does the lack of follow-up mean everybody involved in the
> discussion is happy with this version?

I'm not deliriously happy but I can't think of a better version, and I
suppose it's better than what I suggested. In other words, I'm fine
with the patch.

Jan
