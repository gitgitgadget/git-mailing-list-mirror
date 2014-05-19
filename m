From: Anders Kaseorg <andersk@MIT.EDU>
Subject: Re: [PATCH] Documentation/technical/api-hashmap: Remove source
 highlighting
Date: Mon, 19 May 2014 19:40:35 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1405191839230.44324@all-night-tool.MIT.EDU>
References: <alpine.DEB.2.02.1405170707260.44324@all-night-tool.MIT.EDU> <20140517152219.GA31912@hudson.localdomain> <alpine.DEB.2.02.1405172035160.44324@all-night-tool.MIT.EDU> <xmqq4n0l3dc7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 20 09:49:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmXAs-0000Rb-RV
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 01:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbaESXkl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2014 19:40:41 -0400
Received: from dmz-mailsec-scanner-8.mit.edu ([18.7.68.37]:57542 "EHLO
	dmz-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750894AbaESXkj convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 19:40:39 -0400
X-AuditID: 12074425-f79746d000000ecc-bf-537a9676c500
Received: from mailhub-auth-3.mit.edu ( [18.9.21.43])
	(using TLS with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by dmz-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 0C.9F.03788.6769A735; Mon, 19 May 2014 19:40:38 -0400 (EDT)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id s4JNeb8B009994;
	Mon, 19 May 2014 19:40:38 -0400
Received: from localhost (all-night-tool.mit.edu [18.9.64.12])
	(authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id s4JNeZx2020276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 19 May 2014 19:40:36 -0400
In-Reply-To: <xmqq4n0l3dc7.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42IR4hTV1i2bVhVs0PRWw6LrSjeTRUPvFWaL
	N49yHZg9ds66y+5x8ZKyx+dNcgHMUVw2Kak5mWWpRfp2CVwZnSc3MRccFqnYcGwGawPjL4Eu
	Rk4OCQETiZ9fpzNC2GISF+6tZ+ti5OIQEpjNJDH31Sd2CGcjo0Rb4y4mCGc3k8SOo+fBWlgE
	tCVWfvjBBGKzCahJzN0wmR3EFgGyJ7YdYgGxmQVsJaafvckKYgsLhEncfXQVzOYUsJaYcqgb
	rJ5XwENi/8pmNhBbSOABo8S5LUEgtqiArsTm7qVsEDWCEidnPoGaqS5x4NNFRghbW+L+zTa2
	CYyCs5CUzUJSNgtJ2QJG5lWMsim5Vbq5iZk5xanJusXJiXl5qUW6Fnq5mSV6qSmlmxhBAc3u
	orqDccIhpUOMAhyMSjy8B8SrgoVYE8uKK3MPMUpyMCmJ8t6ZCBTiS8pPqcxILM6ILyrNSS0+
	xCjBwawkwrszFSjHm5JYWZValA+TkuZgURLnfWttFSwkkJ5YkpqdmlqQWgSTleHgUJLgtZsK
	1ChYlJqeWpGWmVOCkGbi4AQZzgM03Bukhre4IDG3ODMdIn+KUVFKnFdvClBCACSRUZoH1wtL
	OK8YxYFeEea1BGnnASYruO5XQIOZgAb/XVwJMrgkESEl1cBYvTla04BV8/H7d8qHC80z3Bd2
	L1Sz52U0XZ3gUZRtcflF6Rs7g50rP2119soxSEphsareqpJQ+CLyREQap8aFesHOl7EXqms2
	O/e2l085mSjuvU2Dp3L/mtsbj0/xyFn1f0cB6w3WP5py5m/0i04ftShZ9WlySxbf 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 19 May 2014, Junio C Hamano wrote:
> If Ubuntu does not want to use highlight, it can apply a change like =
the=20
> patch in question as part of their fork to make the end result=20
> consistent and they are failing to do so.

Sure, Ubuntu can apply that patch, but the larger problem remains: if t=
he=20
Ubuntu packaging is even slightly different from Debian=E2=80=99s, it i=
s no longer=20
eligible for automatic synchronization from Debian.

When that has happened in the past, the result was that the Ubuntu vers=
ion=20
languished far behind the Debian version, because Canonical doesn=E2=80=
=99t have=20
the manpower to manually merge every Debian update.  Ubuntu 9.04 shippe=
d=20
with Git 1.6.0.4 instead of 1.6.2.4 because they had failed to update=20
their packaging after patching out a dependency on cvsps.

If this Ubuntu nonsense were obstructing something important upstream,=20
then of course I would be yelling at Ubuntu to get their act together; =
in=20
that case, I filed a main inclusion report to get Canonical to official=
ly=20
support cvsps (https://bugs.launchpad.net/bugs/369111) so Ubuntu could=20
drop their patch.  But here we=E2=80=99re talking about syntax highligh=
ting in one=20
page of internal documentation that basically nobody is going to read, =
and=20
that argument wouldn=E2=80=99t carry any weight.

We could put the patch into Debian instead of Ubuntu to eliminate the=20
Ubuntu delta; Jonathan has been friendly enough to Ubuntu that I think =
he=20
would grudgingly agree.  But I=E2=80=99m submitting it upstream because=
 other=20
distros will eventually run into the same problem: there=E2=80=99s no o=
bvious cue=20
that source-highlight needs to be added as a new dependency besides a=20
warning message buried in the middle of the build log.

> How bad does the documentation look with the patch applied (I know ho=
w=20
> bad it looks without source-highlight installed)?  If it is not too b=
ad,=20
> then it sounds like a sensible solution to drop the highlight markup=20
> unconditionally like the patch that started this thread does, taking =
the=20
> "common denominator" approach.  You seem to agree, and I do not objec=
t,=20
> either.

Original version with syntax-highlight installed (pretty):
http://web.mit.edu/andersk/Public/api-hashmap/old-highlight.html

Original version with syntax-highlight missing (corrupted):
http://web.mit.edu/andersk/Public/api-hashmap/old-no-highlight.html

Patched version (boring but readable):
http://web.mit.edu/andersk/Public/api-hashmap/patched.html

Anders
