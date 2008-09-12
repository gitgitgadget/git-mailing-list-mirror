From: dhruva <dhruva@ymail.com>
Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
Date: Fri, 12 Sep 2008 16:41:28 +0530 (IST)
Message-ID: <255296.30923.qm@web95003.mail.in2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>, David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri Sep 12 13:22:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6j3-0001mQ-2V
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 13:22:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801AbYILLSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 07:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYILLSN
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 07:18:13 -0400
Received: from n1a.bullet.mail.in2.yahoo.com ([203.104.19.38]:37943 "HELO
	n1a.bullet.mail.in2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752477AbYILLSM convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 07:18:12 -0400
Received: from [202.86.4.170] by n1.bullet.mail.in2.yahoo.com with NNFMP; 12 Sep 2008 11:18:09 -0000
Received: from [203.104.17.88] by t1.bullet.in.yahoo.com with NNFMP; 12 Sep 2008 11:18:09 -0000
Received: from [127.0.0.1] by omp102.mail.in2.yahoo.com with NNFMP; 12 Sep 2008 11:18:09 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 493711.46414.bm@omp102.mail.in2.yahoo.com
Received: (qmail 30951 invoked by uid 60001); 12 Sep 2008 11:11:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=ymail.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=t7eNoQGO+n5PEabNtyop0b+Q1zalCBtyn2yfNs1P0EqCWGrqZ3OYioBJzpduqJB9+Tyny1OTIXLAR4QC051GyMlnuML2Q7YQGsUtc5YAvP7w7gBoAHcyUkBy1SrYzKpnrygBukbEKiBzrmPw6Ixb2sGq3LbxZOBjGWLs5w/nnWo=;
X-YMail-OSG: H7R0NG0VM1lENhMeNz68ExOxQ5AnxXQJxM8whBU6npOkFMG6BbBFVW8O9P30C9ay.L8GVipsBEhH1xNdcDSKWbqiiss60ouC3TV4DByRG8b0blPLZAo57.UvFDCL3Ac-
Received: from [202.3.112.9] by web95003.mail.in2.yahoo.com via HTTP; Fri, 12 Sep 2008 16:41:28 IST
X-Mailer: YahooMailRC/1096.28 YahooMailWebService/0.7.218.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95712>

Hello,



----- Original Message ----
> From: Jakub Narebski <jnareb@gmail.com>
> To: David Lang <david@lang.hm>
> Cc: git@vger.kernel.org
> Sent: Friday, 12 September, 2008 4:14:58 PM
> Subject: Re: Git User's Survey 2008 partial summary, part 5 - other SCM
> 
> On Fri, 12 Sep 2008 00:51, david@lang.hm wrote:
> > On Thu, 11 Sep 2008, Jakub Narebski wrote:
> > 
> > > A bit suprising for me is high place of Perforce.  Another strange
> > > thing (and a bit alarming) is that MS Visual SourceSafe has higher
> > > place than Monotone; but that might be caused by different design and
> > > different target groups of Monotone and Git, which might have caused
> > > that the communities have almost no overlap; people choose either Git
> > > or Monotone, one or the other.  BitKeeper has also a very low number
> > > of active users among Git users... but that is not that strange,
> > > considering history.
> > 
> > I think you are making the wrong assumption here.
> > 
> > Someone may use CVS becouse they contribute to a project that is only 
> > availabe via CVS
> > 
> > Someone may use Perforce becouse that is the VCS that their company uses

I am in that situation...

> True, I have forgot that "I use this SCM" (or "I used this SCM") doesn't
> necessarily mean that one _choose_ this SCM.  One can use some SCM
> because it is SCM project uses, or because their company requires it;
> but not necessary, as git-svn and git-p4 show one can use Git, and
> make it interact with respectively Subversion and Perforce, and trying
> to make it look like one uses this other SCM.

Since we cannot change management to decide on using git instead of whatever they are using overnight. Best is to have tools like git-p4/git-svn which allows interoperability. Once people gain confidence, they can replace that whatever SCM with git. That is the path I am planning at my place of work.

-dhruva



      Get an email ID as yourname@ymail.com or yourname@rocketmail.com. Click here http://in.promos.yahoo.com/address
