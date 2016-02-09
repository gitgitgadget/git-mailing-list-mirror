From: Matt McCutchen <matt@mattmccutchen.net>
Subject: git(1) man page has link to out-of-date googlecode site
Date: Tue, 09 Feb 2016 15:18:18 -0500
Message-ID: <1455049098.2511.203.camel@mattmccutchen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 21:18:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTEk0-0007KK-CL
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:18:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbcBIUSY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Feb 2016 15:18:24 -0500
Received: from homie.mail.dreamhost.com ([208.97.132.208]:59160 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755221AbcBIUSX convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Feb 2016 15:18:23 -0500
Received: from homiemail-a2.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id 80357280070
	for <git@vger.kernel.org>; Tue,  9 Feb 2016 12:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	message-id:subject:from:to:date:content-type:mime-version:
	content-transfer-encoding; s=mattmccutchen.net; bh=dZqTcmSxLG39d
	fEMmLhThnCRzNQ=; b=XXc7jKEIjTFaM8hiM6HsJ3EA1gM6/XTfI+82A6EVAKO0d
	7VfiHuhA2ZM+LN3qeAV9JtJY3jC5AVooO/jizhkYUaYH+al+jr8lAN52cbK7TAHA
	QCUve0CLXnRIRPn60zDgmmfdIlDxrhUBeNYbWqqrzJhZoXtPfqlA2NuAA9od9s=
Received: from main (30-9-175.wireless.csail.mit.edu [128.30.9.175])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTPSA id 3205328006D
	for <git@vger.kernel.org>; Tue,  9 Feb 2016 12:18:23 -0800 (PST)
X-Mailer: Evolution 3.18.4 (3.18.4-1.fc23) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285854>

I noticed that near the top of the git(1) man page, there is a link to=C2=
=A0
http://git-htmldocs.googlecode.com/git/git.html, which apparently has
not been updated since August 2015
(https://code.google.com/archive/p/git-htmldocs/source/default/commits)=
=2E
Should this link just be removed, or replaced with
http://git-scm.com/docs=C2=A0(which lists a subset of the pages) or per=
haps
http://git-scm.com/docs/git?=C2=A0 I will be happy to write the patch.

Matt
