From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [msysGit] Re: ANN: Git for Windows 1.7.0.2 preview 20100309
Date: Tue, 23 Mar 2010 09:54:04 +0800
Message-ID: <46dff0321003221854t2d95d18dx1a6cdf1174ea2efd@mail.gmail.com>
References: <alpine.DEB.1.00.1003091921140.18499@intel-tinevez-2-302>
	 <alpine.DEB.2.00.1003221012290.11364@ds9.cixit.se>
	 <alpine.DEB.1.00.1003221155200.7596@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Krefting <peter@softwolves.pp.se>,
	msysgit <msysgit@googlegroups.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 23 02:54:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NttJt-000534-LP
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 02:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774Ab0CWByH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 21:54:07 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:62114 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074Ab0CWByF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 21:54:05 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1398172qwh.37
        for <git@vger.kernel.org>; Mon, 22 Mar 2010 18:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Hy7/EXbfSMz71peOZRHUJ37nYngs5xWcZSIn4AhSer4=;
        b=ObIoK76EfPPbdeyahhUk7f1iJ3ltal8tUa1FHqAf9bPWPlYw/u7S3Gku3QIZfs61nN
         DrpKuoH7q4FMRBl07jiv45Mgc/z5Gaf9DohxB/dFi2oWL62SbKmWT2maLxFbm38qKmP0
         gz96k/j0AID+jawuabMQXfYkjwKkTCK4viUx4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=cjq3tLb6Tpxy/wAIdU0fxKtOCmULXYUxRHucu9PLAG2k5QZmBc1VVa8l87tmzmcR8D
         kzZiprg1QC/QSpaSJI2NVMtk0moa63E03An3+0YNPIAH6bL95xu2bpEa3Gi6RlorR0pT
         gzDOgx4EOzJ4cRumxHvLlzZgVit0ZnR6RVKZI=
Received: by 10.229.98.129 with SMTP id q1mr195296qcn.100.1269309244392; Mon, 
	22 Mar 2010 18:54:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1003221155200.7596@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142982>

On Mon, Mar 22, 2010 at 6:58 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 22 Mar 2010, Peter Krefting wrote:
>
>> Johannes Schindelin:
>>
>> > Git Release Notes (Git-1.7.0.2-preview20100309)
>> > Last update: 9 March 2010
>>
>> The redesigned installer seems to have lost the option to choose to use
>> Putty over OpenSSH, is there any documentation on how to set it up to
>> use Putty anyway?
>
> Support for Putty has not been taken away, but it caused us so many
> problems (because people cannot easily accept new host keys). So it is
> only offered if you proved that you can accept new host keys yourself, and
> saved a session.
>
With putty and pageant, the key with passphrase can be used.
Is there any way to use key with passphrase when using the msysgit ssh?
