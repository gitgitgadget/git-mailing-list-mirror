From: Akira Kitada <akitada@gmail.com>
Subject: Re: git-patches list?
Date: Wed, 14 Jan 2009 00:55:38 +0900
Message-ID: <90bb445a0901130755t6ea98bcco6b6663d806dcc2e6@mail.gmail.com>
References: <90bb445a0901121543q29d30d49yaa723b4b913a4b31@mail.gmail.com>
	 <7vr638f5ch.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 16:57:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMlda-00005J-CK
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 16:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222AbZAMPzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 10:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbZAMPzm
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 10:55:42 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:44102 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751936AbZAMPzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 10:55:41 -0500
Received: by rv-out-0506.google.com with SMTP id k40so60467rvb.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dcLIrnTeMkhPxVN1mrraIWm9Q/CXo3DIEU2bzeNCDRY=;
        b=gNTSgQ6jNUtpjRD2QZcY/G4QYuj8coMuGS563QS1ySVm6hHIqNmiiS0LZHHAMx4HWc
         2XBiIITl08ztf+rG1GinQDt6sW0R/WiXE5IK9Q/jVEPsVdI3I4bqNUFiBWP/t1gjNL4O
         jEA8m7GV3Mrxzyltw/yLjQaiFclnT8lPNtX54=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lO7fK7tapA6A3pTJ8ZNScJXivpdo3+z+byRp8VSFlz2+aEcVhXRJh2xp1ke+53/Rxo
         Dne8vSlJZ1JbIRkQ7uMaj3VWb3xM1Ra3veiAeB7ezJlqvcrECl6Org096IHmT5eyosGe
         hfC9+M4wYyPTZu1koLGx2J8VXCtgn4IDV6nQA=
Received: by 10.140.177.15 with SMTP id z15mr15367554rve.114.1231862138823; 
	Tue, 13 Jan 2009 07:55:38 -0800 (PST)
In-Reply-To: <7vr638f5ch.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105503>

This list seems to be used as a bug tracker, discussing git development,
user questions, announcement etc.
I thought this is so unusual list that something should be wrong here,
but it turned out that it looks working right in mysteryous way.
I take that back now.
Hmm, interesting...

Thanks,

On Tue, Jan 13, 2009 at 8:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Akira Kitada <akitada@gmail.com> writes:
>
>> Can I propose having another mailing list for posting patches to avoid
>> daily mail flood to this list?
>>
>> Yes, I can filter out the emails but still...
>
> This list has always been the only place where git development happens.
> It would make the development very awkward to set up another list only for
> patches, forbid patches to be sent to anywhere but that new list, but
> still discuss the patches on this list.
>
> It does not make much sense to me.
>
> Consider what you would do when you see a problem somebody is having on
> this list, and wanted to respond with a quick "this may fix it" patch?
> Should you be sending that to the patches list, and sending a separate
> message to this list saying that you have a potential fix in mind you
> would want to discuss here, but the patches list rule mandated that you
> had to send the patch to the other list, asking people who are reading
> this list to look at the other list as well?
>
> And no, having a separate "user list" won't solve the above problem either
> and that is not what I am suggesting.
>
> Not that I am seeing any problem right now; I am saying that the split
> list as you suggest _will_ create problems.
>
