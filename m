From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Review of git multimail
Date: Thu, 04 Jul 2013 10:27:05 +0200
Message-ID: <51D531D9.10203@alum.mit.edu>
References: <1372793019-12162-1-git-send-email-artagnon@gmail.com> <51D36BD8.1060909@alum.mit.edu> <CALkWK0=taYiV3UTaj9r-FLdaCeZRzVBTp_MH4sQt8-v+YYqbaA@mail.gmail.com> <87ppuzz6xr.fsf@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jed Brown <jed@59A2.org>
X-From: git-owner@vger.kernel.org Thu Jul 04 10:27:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uueso-0000GP-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 10:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933618Ab3GDI1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 04:27:13 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44909 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933426Ab3GDI1J (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jul 2013 04:27:09 -0400
X-AuditID: 12074414-b7f626d0000001f1-b6-51d531dcbe09
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1B.7E.00497.CD135D15; Thu,  4 Jul 2013 04:27:08 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r648R5Ik013509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 4 Jul 2013 04:27:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <87ppuzz6xr.fsf@mcs.anl.gov>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsUixO6iqHvH8GqgwZ7NKharZj5mt+i60s1k
	sW3hMSYHZo+Wh7NZPXbOusvu8XmTXABzFLdNUmJJWXBmep6+XQJ3xuFDMQU7ZSr2nV7E2MD4
	QayLkZNDQsBEYvKRP2wQtpjEhXvrgWwuDiGBy4wSk1a+Z4JwrjJJ9M1+zwxSxSugKbFu50oW
	EJtFQFVi0tledhCbTUBXYlFPM1ADB4eoQJjEld+qEOWCEidnPgErFxGQkdjZuBOsnFnAV+L6
	twZGEFtYQEXi4uLVzBC7jjBKtEz9zAqS4ATadWr3NRaIBh2Jd30PmCFseYntb+cwT2AUmIVk
	xywkZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuhl5tZopeaUrqJERK8IjsYj5yU
	O8QowMGoxMN7wPxKoBBrYllxZe4hRkkOJiVR3hqDq4FCfEn5KZUZicUZ8UWlOanFhxglOJiV
	RHidOIByvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoSvL0gQwWLUtNT
	K9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBkRpfDIxVkBQP0N5tIO28xQWJuUBRiNZTjJYc
	k89uec/IceAHiLz5fut7RiGWvPy8VClx3h0gDQIgDRmleXDrYCnsFaM40PfCvFdAqniA6Q9u
	6iughUxAC/+yXwFZWJKIkJJqYKznmbBoybGwxHILL841f7tlD/RutJjX3Hv6+hbbvJn81ZK8
	/npqzpcS3ZUdhTim70iM+Pj25txS/rsPxeYFtJUe/HmEw0SD55C80eSOeP2caPMO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229561>

Thanks for all of the information.

On 07/03/2013 11:09 PM, Jed Brown wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
>> Yeah, this is good reasoning.  And yes, I'm on Arch: python points to
>> python3, and python2 points to python2.  
> 
> I'm also on Arch and it has been this way since October 2010 [1].
> Ubuntu plans to remove python2 from the desktop CD images in 14.04 [2],
> so having code that does not work with python3 will become more painful
> pretty soon.

It may not be on the CD image, but python2 will undoubtedly continue to
be supported in the Ubuntu repositories; i.e., it is just an "apt-get
install" away.  (For that matter, I don't think Git itself is on the
Ubuntu CD image.)

> Note that RHEL5 has only python2.4 and will be supported through March,
> 2017.  Since it is not feasible to have code that works in both python3
> and any versions prior to python2.6, any chosen dialect will be broken
> by default on some major distributions that still have full vendor
> support.

I think for a server-oriented program like git-multimail it is more
important to support old versions of Python than to support the
bleeding-edge versions.  For user-oriented programs a different
conclusion might be reached.

My vague, long-term plan is roughly:

* Continue to support Python 2.4 or at least 2.5 for the next year or
two.  This excludes any reasonable hope of simultaneously being Python
3.x compatible, so don't worry about 3.x for now (though
backwards-compatible and non-hideous changes that move in the direction
of Python 3.x compatibility are of course welcome).

* At some point, abandon support for the older Python 2.x releases and
start using 3.x-compatibility features that were added in Python 2.6 and
2.7.

* Make string handling Unicode-correct.

* Then evaluate the situation and decide between two courses of action:

  * Evolve the script to work with both Python 2.7 (and maybe 2.6) and
Python 3.3 (and maybe 3.2) simultaneously.

  * Fork development of a Python 3.x version while retaining a 2.x
version in maintenance mode.

>> A couple of thoughts while we're on the subject:
>>
>> 1. We should probably convert git-remote-{hg,bzr} to use this style
>> too: 
> 
> Python-2.6.8 from python.org installs only python2.6 and python, but not
> python2, so this will break on a lot of older systems.  Some
> distributions have been nice enough to provide python2 symlinks anyway.
> 
> Michael's rationale that at least the error message is obvious still
> stands.

The approach I've taken in git-multimail isn't necessarily applicable to
git-remote-*.  The main difference is that git-multimail *has to* be
installed by a repository administrator to have an effect (either by
being copied or linked to $GIT_DIR/hooks or by adding a script there
that refers to git_multimail.py).  So the admin, at that time, can
decide what python is best to use on his system and adjust the shebang
line or create a "python2" symlink or whatever.

The git-remote-* scripts are meant for users, who simply want to execute
them without thinking.  So in that case, the scripts should be installed
to the default $PATH with the correct shebang line already in place for
the local environment.  Thus their shebang lines will tend to be decided
by packagers, not end users, and this difference changes the situation.
 I think they should be managed via build step that rewrites the scripts
to use a build-time-configured Python interpreter.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
