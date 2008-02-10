From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: remove .git/SQUASH_MSG upon successful commit
Date: Sat, 09 Feb 2008 23:25:51 -0800
Message-ID: <7v4pch2ry8.fsf@gitster.siamese.dyndns.org>
References: <20080208095358.25666.qmail@b4daf7aef4dba9.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 08:27:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO6bF-0003B8-7z
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 08:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758828AbYBJH0K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 02:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758364AbYBJH0I
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 02:26:08 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59430 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758090AbYBJH0E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 02:26:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FFFD115E;
	Sun, 10 Feb 2008 02:26:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1847115C;
	Sun, 10 Feb 2008 02:25:58 -0500 (EST)
In-Reply-To: <20080208095358.25666.qmail@b4daf7aef4dba9.315fe32.mid.smarden.org>
	(Gerrit Pape's message of "Fri, 8 Feb 2008 09:53:58 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73323>

Gerrit Pape <pape@smarden.org> writes:

> After doing a merge --squash, and commit afterwards, the commit messa=
ge
> template SQUASH_MSG in the git directory is not removed, which means =
that
> the content of SQUASH_MSG is used as default commit message for all
> subsequent commits.  So have git commit remove the file SQUASH_MSG fr=
om
> the git directory upon a successful commit.

As your message was marked with

        MIME-Version: 1.0
        Content-Type: text/plain; charset=3Dunknown-8bit

I am getting this, which would most likely to be wrong rendition
of Fr???ic's name.

> The problem was discovered by Fr=E9=A6=98=E9=A7=BBic Bri=E9=91=BDe, r=
eported through

Is the name "Fr=C3=A9d=C3=A9ric Bri=C3=A8re"?
