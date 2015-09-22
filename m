From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Unable to create temporary file
 '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR': Permission denied
Date: Tue, 22 Sep 2015 22:00:08 +0200
Organization: gmx
Message-ID: <37ca95b3fef79e348fb5ba68cd21c590@dscho.org>
References: <1440157010.1759.83.camel@transmode.se>
 <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
 <1442245035.10125.18.camel@transmode.se>
 <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
 <1442508864.21964.26.camel@transmode.se>
 <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
 <xmqqpp1bbtvz.fsf@gitster.mtv.corp.google.com>
 <1442855328.29498.30.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, pclouds@gmail.com, git@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Tue Sep 22 22:00:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeTjl-0006Tq-31
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 22:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934055AbbIVUAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 16:00:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:65005 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933591AbbIVUAS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 16:00:18 -0400
Received: from dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Meg8W-1a2jkg1ohk-00OGhe; Tue, 22 Sep 2015 22:00:10
 +0200
In-Reply-To: <1442855328.29498.30.camel@transmode.se>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:1nPxjAT4bB6SUvh0cRAf3kN8h/ZC9EHU7tGVNQaGV4t0Tpm8fKW
 jPpkiPqnr7CPwqtA2mu4ejojjUrJCTWN+8zO8KJo+0TyGutoIt9zM2nKyOo5XCIFDJcArIL
 mCawq/55YsYv7QL84hPwBrC71lyfl6AERkQQoaooPeqd29lsRvmSdK8m3/KDiKP87etRXHw
 2vC9gTt+Ly6uwsQW4SawA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cvX/weqt9qU=:+gktrWH90kYSdyo9aXOuJc
 Pm7yAgoGHsvEvtF2Q0DI75PQ4pnFSBdf3dLP5ClwHkbpS9aVk2yhRf6nGkpR3g/VFWv3az8Mb
 yDOV0o8aGPkvtt8E5RVLPhPyL6CoiP3BiM9nvn/fmnNAnRevnQb4qr2glAhlUH4nz5sTKwsUv
 yHMEggsq6EmykEz1vD+eI04VmOC4+PkbEJPmcDF9seEG9lMiiBs/Jg21aL9Jj5vq3BR3NfyZx
 rjwzGPSzyTvX2cJ3XWxFsO3afZbE4dfj0QE32DFtpfXQdqljOnhLaIJm0DPHVPUZDT8T0sf9D
 Ey6Cv4jTeus2Y+03OqWFGsRNM9L4laYkS/5xRSFTAxWXz/bhG8gG/cFPoCD6dpwt/rJlLe1Oz
 RVdfERvrgVaoUzHFtbm/1jKCL+CRgDM4lMaAvW3afccPkgaFdGc6WJ4EKji/lFiyUBlYzWUYE
 biGIsiuehAChSD4WG2X0R1F7zsWFCF8xxniip69LRqx3C4obb+a/VNEnikc4r+q1xmDkyQZ0Z
 fUDEUcQ+19SAK7qUxc08V8aSEtydNaOj99pySozpphUO/Dyeikn5xy5pdKH17z6cc1TihLDri
 Ehg3JMB62hzGLr1kSrma/iUs1AlaDxeuof06A36sOFxmCKXD1DkPdNA2VB3j4DvJjxWKAFR1D
 QvuR9vreZvvKd4IUX/KC4po3XfKO1S4ac/QIRSeYmQH5s1vIGFDNwWJgr3KSlQpQeGrR/KbKD
 mODfUN7odTHdqiqcCaae3RIpLlAePE3A1NV4VA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278427>

Hi Joakim,

On 2015-09-21 19:08, Joakim Tjernlund wrote:
> On Mon, 2015-09-21 at 09:48 -0700, Junio C Hamano wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>> > Is it really necessary to remove write access in $GIT_DIR? Do we (git
>> > devs) have some guidelines about things in $GIT_DIR?
>>
>> Those who are allowed to "git push" into it should be able to write
>> there.  It is a different matter that "git" program itself may make
>> a policy decision to disallow some operations that the filesystem
>> bits alone would have allowed (e.g. you can arrange the "pusher" to
>> only come over the wire via "receive-pack" and "receive-pack" may
>> deliberately lack support for writing into $GIT_DIR/config).
>>
> 
> I view $GIT_DIR similar to "/" and "/tmp". Normally one does not let
> normal users write to "/"
> as you want to keep this level clean. It is not obvious to everybody
> what files are important
> under $GIT_DIR when mixed with tmp files etc.
> $GIT_DIR/tmp would solve this nicely.

By now it is pretty clear that you won't find many people here you share your opinion about locking down the Git directory.

The reason should be easy to understand: Git's concept is based on the idea that you have full control over your repository. Other repositories you might only have read access.

But this idea you have, to somehow introduce fine-grained levels of control, this idea would imply that all of a sudden Git is no longer free to write to its files as it likes. And as far as Git is concerned, everything inside .git/ *are* its files.

So in essence, the core concept of Git -- you clone a repository you cannot write to so that you have a local repository you can do *anything you like* to -- is pretty much incompatible with this idea of a selective lock down of files in .git/ that not only would require you to know very exactly what files Git might want to write, but also to keep yourself up-to-date with Git's development as to which files it might want to write for *every* new version. Making only .git/tmp/ a writable location further fails to acknowledge the fact that the hierarchy of to-be-written files follows the function of those files, not any write permission hierarchy. Since the idea seems so alien to Git's core concept, I called it "overzealous". If that hurt your feelings, I am sorry and would like to apologize
 .

Having said all that, I believe that reiterating this idea without pointing to any benefit will continue to fail to convince people that the idea is sound and that Git's core concept should change. If you need to exert more control in a specific repository, you simply make it accessible only as a non-file-system remote (where only `git`, `git-receive-pack` and `git-upload-pack` are allowed to be executed) and define hooks that can accept or deny on a *much* finer level than file system permissions ever could, after all.

Ciao,
Johannes
