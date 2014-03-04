From: David Kastrup <dak@gnu.org>
Subject: Re: git compile with debug symbols
Date: Tue, 04 Mar 2014 16:53:04 +0100
Message-ID: <87a9d6hsf3.fsf@fencepost.gnu.org>
References: <1393947964.16150.YahooMailNeo@web162902.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Mahesh Pujari <pujarimahesh_kumar@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:53:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKreo-0003MK-Vq
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 16:53:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbaCDPxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 10:53:21 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:49898 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755151AbaCDPxU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 10:53:20 -0500
Received: from localhost ([127.0.0.1]:48940 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKreh-0005gf-6l; Tue, 04 Mar 2014 10:53:19 -0500
Received: by lola (Postfix, from userid 1000)
	id A617AE04EF; Tue,  4 Mar 2014 16:53:04 +0100 (CET)
In-Reply-To: <1393947964.16150.YahooMailNeo@web162902.mail.bf1.yahoo.com>
	(Mahesh Pujari's message of "Tue, 4 Mar 2014 07:46:04 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243350>

Mahesh Pujari <pujarimahesh_kumar@yahoo.com> writes:

> Hello,
> =A0I am trying to compile git with debug symbols and failed to do so
> (basically I am a noob), can some one direct me to links or mailing
> list (have searched but couldn't find) or doc's so that I can debug
> git using gdb.

git is compiled with debug symbols by default.

--=20
David Kastrup
