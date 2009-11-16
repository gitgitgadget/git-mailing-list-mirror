From: Bill Lear <rael@zopyra.com>
Subject: Re: Git graph with branch labels for all paths in text environment
Date: Mon, 16 Nov 2009 07:30:14 -0600
Message-ID: <19201.21478.127959.431877@lisa.zopyra.com>
References: <1258373038892-4011651.post@n2.nabble.com>
	<adf1fd3d0911160423q4e21126dm37be7838f0ce8379@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rhlee <richard@webdezign.co.uk>, git@vger.kernel.org
To: Santi B=?iso-8859-1?B?6Q==?=jar <santi@agolina.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 14:31:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NA1f4-0002Xw-6G
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 14:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbZKPNaP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2009 08:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbZKPNaP
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 08:30:15 -0500
Received: from 75-27-130-60.lightspeed.austtx.sbcglobal.net ([75.27.130.60]:53019
	"EHLO zopyra.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401AbZKPNaO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2009 08:30:14 -0500
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id nAGDUIb07130;
	Mon, 16 Nov 2009 07:30:18 -0600
In-Reply-To: <adf1fd3d0911160423q4e21126dm37be7838f0ce8379@mail.gmail.com>
X-Mailer: VM 8.0.11 under Emacs 21.1.1 (i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133008>

On Monday, November 16, 2009 at 13:23:10 (+0100) Santi B=E9jar writes:
>On Mon, Nov 16, 2009 at 1:03 PM, rhlee <richard@webdezign.co.uk> wrote=
:
>> Is there anyway to to view a text based git grah that shows all path=
s with
>> the branch labels? Like a on gitk but ncurses based?
>
>For third-party tools you can check:
>
>http://git-scm.com/tools

Anything that can print this?:

                                       H---I---J topicB
                                      /
                             E---F---G  topicA
                            /
               A---B---C---D  master

I've always liked the text-based format that keeps things in-line, as
above.  Very readable.  I thought someone on this list posted
something about a tool that could produce such graphs from
reasonably-sized git repos.  Anyone have such a thing?


Bill
