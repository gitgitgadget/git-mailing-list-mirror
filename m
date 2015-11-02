From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: Anonymous commit (empty Author and Committer)
Date: Mon, 2 Nov 2015 10:11:23 -0500
Message-ID: <20151102151123.GF21923@csclub.uwaterloo.ca>
References: <56337DF8.5050802@gmail.com> <5633CDCD.10004@gmail.com>
	<5633CE60.8060907@gmail.com> <5633D0C7.2020709@gmail.com>
	<20151030205955.GC21923@csclub.uwaterloo.ca>
	<56345076.30207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: savannah-users@gnu.org, git@vger.kernel.org
To: The development of GNU GRUB <grub-devel@gnu.org>
X-From: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org Mon Nov 02 16:11:41 2015
Return-path: <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>
Envelope-to: gcgsu-savannah-users@m.gmane.org
Received: from lists.gnu.org ([208.118.235.17])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>)
	id 1ZtGln-0007SP-T3
	for gcgsu-savannah-users@m.gmane.org; Mon, 02 Nov 2015 16:11:40 +0100
Received: from localhost ([::1]:42836 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org>)
	id 1ZtGln-0003UY-As
	for gcgsu-savannah-users@m.gmane.org; Mon, 02 Nov 2015 10:11:39 -0500
Received: from eggs.gnu.org ([2001:4830:134:3::10]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lsorense@csclub.uwaterloo.ca>) id 1ZtGlf-0003Ml-IN
	for savannah-users@gnu.org; Mon, 02 Nov 2015 10:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lsorense@csclub.uwaterloo.ca>) id 1ZtGle-0001Hn-N9
	for savannah-users@gnu.org; Mon, 02 Nov 2015 10:11:31 -0500
Received: from mail.csclub.uwaterloo.ca ([129.97.134.52]:35112)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lsorense@csclub.uwaterloo.ca>)
	id 1ZtGlZ-0001Gp-TF; Mon, 02 Nov 2015 10:11:25 -0500
Received: from caffeine.csclub.uwaterloo.ca (caffeine.csclub.uwaterloo.ca
	[129.97.134.17])
	by mail.csclub.uwaterloo.ca (Postfix) with SMTP id D628B20F21;
	Mon,  2 Nov 2015 10:11:23 -0500 (EST)
Received: by caffeine.csclub.uwaterloo.ca (sSMTP sendmail emulation);
	Mon, 02 Nov 2015 10:11:23 -0500
Content-Disposition: inline
In-Reply-To: <56345076.30207@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 129.97.134.52
X-BeenThere: savannah-users@gnu.org
X-Mailman-Version: 2.1.14
Precedence: list
List-Id: Discussion of savannah-announce and any user-oriented topic
	<savannah-users.gnu.org>
List-Unsubscribe: <https://lists.gnu.org/mailman/options/savannah-users>,
	<mailto:savannah-users-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/savannah-users>
List-Post: <mailto:savannah-users@gnu.org>
List-Help: <mailto:savannah-users-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/savannah-users>,
	<mailto:savannah-users-request@gnu.org?subject=subscribe>
Errors-To: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org
Sender: savannah-users-bounces+gcgsu-savannah-users=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280693>

On Sat, Oct 31, 2015 at 08:24:06AM +0300, Andrei Borzenkov wrote:
> If we decide to fix this commit it is better done now, while it is the last
> one. It is annoying but do you have suggestion how it can be done
> differently?

Well the only options are:

1) Leave it alone
2) Break the tree of anyone that already pulled.  (Posting instructions on
how to fix it would at least be nice then).

Not sure how many people regularly pull the tree.

-- 
Len Sorensen
