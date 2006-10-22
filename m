From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 17:50:42 +0200
Message-ID: <200610221750.42662.jnareb@gmail.com>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	<egr3ud$nqm$1@sea.gmane.org>
	<20061016035326.GA8654@hope.sourcefrog.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sun Oct 22 17:51:07 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbfbM-0001Am-OP
	for gcvbg-bazaar-ng@m.gmane.org; Sun, 22 Oct 2006 17:51:04 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1Gbfb4-0005Cc-Kw; Sun, 22 Oct 2006 16:50:46 +0100
Received: from hu-out-0506.google.com ([72.14.214.224])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <jnareb@gmail.com>) id 1Gbfar-0005Bm-Qt
	for bazaar-ng@lists.canonical.com; Sun, 22 Oct 2006 16:50:34 +0100
Received: by hu-out-0506.google.com with SMTP id 27so867492hub
	for <bazaar-ng@lists.canonical.com>;
	Sun, 22 Oct 2006 08:50:33 -0700 (PDT)
Received: by 10.67.30.6 with SMTP id h6mr4178960ugj;
	Sun, 22 Oct 2006 08:50:31 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
	by mx.google.com with ESMTP id e1sm175501ugf.2006.10.22.08.50.31;
	Sun, 22 Oct 2006 08:50:31 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20061016035326.GA8654@hope.sourcefrog.net>
Content-Disposition: inline
To: Undisclosed.Recipients: ;
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29763>

On 14 Oct 2006, Jakub Narebski <jnareb@gmail.com> wrote:
> Jon Smirl wrote:
> 
>> It refers to this comparison chart between source control systems.
>> http://bazaar-vcs.org/RcsComparisons
> 
> It is quite obvious that comparison of programs of given type (SMC)
> on some program site (Bazaar-NG) is usually biased towards said program,
> perhaps unconsciously: by emphasizing the features which were important
> for developers of said program.

There are also clashes with SCM terminology used differently by different
projects, which are sometimes couled with differences in philosophy,
and sometimes by different undestanding of given name.

For example "lightweight checkouts" and "normal/heavyweight checkout"
are from what I gather, is supporting "CVS/centralized model" and
"disconnected CVS model" (i.e. we can commit changes locally with
no network access, and we save local changes), at least when we
do "checkout" remotely and not on one local filesystem out-of-the-box.
