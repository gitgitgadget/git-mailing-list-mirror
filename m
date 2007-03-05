From: Bill Lear <rael@zopyra.com>
Subject: Re: Git checkout preserve timestamp?
Date: Mon, 5 Mar 2007 13:04:27 -0600
Message-ID: <17900.27067.247950.419438@lisa.zopyra.com>
References: <17895.18265.710811.536526@lisa.zopyra.com>
	<20070302091426.GA2605@diana.vm.bytemark.co.uk>
	<17896.9631.316001.869157@lisa.zopyra.com>
	<Pine.LNX.4.63.0703021618000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070302162136.GA9593@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703022018190.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<20070305072323.GA31169@diana.vm.bytemark.co.uk>
	<Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:04:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOIUH-0000TN-0j
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 20:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbXCETEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Mar 2007 14:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbXCETEj
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 14:04:39 -0500
Received: from mail.zopyra.com ([65.68.225.25]:60034 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932253AbXCETEi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2007 14:04:38 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l25J4Tm13590;
	Mon, 5 Mar 2007 13:04:29 -0600
In-Reply-To: <Pine.LNX.4.63.0703051230390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41474>

On Monday, March 5, 2007 at 12:32:07 (+0100) Johannes Schindelin writes=
:
>Hi,
>
>On Mon, 5 Mar 2007, Karl Hasselstr=F6m wrote:
>
>> On 2007-03-02 20:21:17 +0100, Johannes Schindelin wrote:
>>=20
>> > On Fri, 2 Mar 2007, Karl Hasselstr=F6m wrote:
>> >
>> > > However, given that your file timestamps have been bumped (witho=
ut
>> > > file content changes),
>> >
>> > There were changes. Only that they have been taken back, but that =
is
>> > _another_ change.
>>=20
>> Since the content is exactly the same as before, I'd be of the stron=
g
>> opinion that nothing has changed as far as the make system should be
>> concerned.
>
>You are missing an important point here: there _was_ a change.

Physically, yes, the bits were changed, but logically nothing has
changed, at least in the scenario I outlined.


Bill
