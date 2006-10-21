From: Jeff Licquia <jeff@licquia.org>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 19:42:47 -0400
Message-ID: <1161474168.9241.188.camel@localhost.localdomain>
References: <45357CC3.4040507@utoronto.ca>
	<20061021191949.GA8096@coredump.intra.peff.net>
	<20061021214629.GO75501@over-yonder.net>
	<200610220025.32108.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 01:42:56 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbQUR-0002hk-2F
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 01:42:55 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbQUP-0008NO-Eu; Sun, 22 Oct 2006 00:42:53 +0100
Received: from jeffindy.licquia.org ([216.37.46.185])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jeff@licquia.org>) id 1GbQUN-0008Mh-Cu
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 00:42:51 +0100
Received: from server1.internal.licquia.org (unknown [192.168.50.3])
	by jeffindy.licquia.org (Postfix) with ESMTP id 802406FD88;
	Sat, 21 Oct 2006 19:42:50 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.52.6])
	by server1.internal.licquia.org (Postfix) with ESMTP id 0B69C980DA;
	Sat, 21 Oct 2006 19:42:50 -0400 (EDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 2E5E24E4025; Sat, 21 Oct 2006 19:42:48 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610220025.32108.jnareb@gmail.com>
X-Mailer: Evolution 2.6.3 
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29690>

On Sun, 2006-10-22 at 00:25 +0200, Jakub Narebski wrote:
> I wonder if searching for one's own commits isn't the sign that
> the project is of one-main-developer size (i.e. small project,
> without large number of distributed contributors). I think in large 
> project you rather ask of history of specified file, of specified part 
> of project (specified directory), ask about why certain change was 
> introduced etc.

I don't think so.  Recently, I've been trying to track a particular
patch in the kernel.  It was done as a series of commits, and probably
would have been its own branch in bzr, but when I was trying to group
the commits together to analyze them as a group, the easiest way to do
that was by the original committer's name.

Now, there's probably a better way to hunt that stuff down, but in this
case hunting the user down worked for me.  (It may have made a
difference that I was using gitweb instead of a local clone.)

And the case of hunting down your own commits is just a degenerate case
of hunting down someone else's.
