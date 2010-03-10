From: Christian MICHON <christian.michon@gmail.com>
Subject: Re: [msysGit] ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Wed, 10 Mar 2010 14:19:49 +0100
Message-ID: <46d6db661003100519v7fe84ffg4ffb1cf3aae15778@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
	 <46d6db661003092258t22f2ee5ga720f18a859db957@mail.gmail.com>
	 <alpine.DEB.1.00.1003101329550.3006@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 10 14:20:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpLpY-0005FU-Hz
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 14:20:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756468Ab0CJNTy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Mar 2010 08:19:54 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:38575 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756447Ab0CJNTv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Mar 2010 08:19:51 -0500
Received: by bwz1 with SMTP id 1so4910657bwz.21
        for <git@vger.kernel.org>; Wed, 10 Mar 2010 05:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=XZ1qClzyVQryUDonrBICAmiUgBsh7qC2bwcvlZVw49c=;
        b=q7Cponb3NIWJ/TJFrPFYU1aGRA7/NI7gsxJQjAKFC8Ro1dtj8VI5Hf4jv3l1wyKtoB
         K7pnhDN72/AXt3p7ffZVspaVgYtuKCdNsLMKx2ucyu6Hp2XePRBqu/AMElvx1fJqZB6i
         QXT3Iy4oRTgF5C2Q05pZfOWfVHCx33YX7zZFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LSrvscEmPOOSCPcNgsBLcJkr/DgAUpH2SPqF4rkA6MUDLAmpDWOD+VnSz2mebWhvLk
         sitFIHQm/6mvSWcR8JrGatuCsKD4ejSHhP4fOPmwM4EaZZdWAX2vIleKPgwFOEFzJwG7
         fZvy01Uku4TNh3FYx6LDDDdJfKhid5ybqMSIg=
Received: by 10.204.9.152 with SMTP id l24mr1597042bkl.193.1268227189806; Wed, 
	10 Mar 2010 05:19:49 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1003101329550.3006@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141886>

On Wed, Mar 10, 2010 at 1:30 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 10 Mar 2010, Christian MICHON wrote:
>
>> On Tue, Mar 9, 2010 at 7:24 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>>
>> > - .git* files can be associated with the default text editor (issu=
e
>> > =A0 397).
>>
>> I was first mislead by this feature. I thought I could also edit
>> .git/* like config and all...
>>
>> This one feels weird here on Vista: .gitignore or .gitattributes end
>> up having no name visible at all on Explorer file view. I can only s=
ee
>> their real names once I fire the editor, on the title bar of the
>> editor. Is this expected ?
>
> What do you mean? Remember: I do not have Vista, you'll have to help =
me a
> little to understand the problem. Maybe in this case, a screenshot wo=
uld
> help. Or if you have an idea how to solve the issue, a patch :-)
>

What I meant is that in any folder view (icon,list,etc...) I see the
icon corresponding to default editor files (in this case notepad), but
the name is blanked. I cannot see the name of the file until I double
click on it: by then, the name appears in the title bar of notepad. I
hope this time the explaination is clearer.

I'll send a screenshot tonight, not at home right now :-(

I actually installed it on XP here turning this feature off (I want to
find easily my .gitignore and .gitattributes).

No idea on how to solve this yet. I'll look.

--=20
Christian
--
http://detaolb.sourceforge.net/, a linux distribution for Qemu with Git=
 inside !
