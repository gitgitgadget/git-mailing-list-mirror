From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 08 Aug 2007 19:07:04 -0400
Message-ID: <46BA4C98.4050005@gmail.com>
References: <f99cem$4a4$1@sea.gmane.org> <f99nm6$9vi$1@sea.gmane.org>  <f99rei$ou$1@sea.gmane.org> <20070807143616.GO9527@spearce.org>  <20070807145825.GO21692@lavos.net>  <66DD7425-6073-4CA8-BF01-BF07213A4804@zib.de> <30e4a070708071042g5623cb7ak724a8b8e588bd1da@mail.gmail.com>  <07BB2580-4406-496F-8ACE-F6A03D1687BE@zib.de>  <30e4a070708080650j5de7ee92p4acd7e82de7d9dff@mail.gmail.com>  <A2397231-1B81-4AD4-87CB-8FF8FB9BA89C@zib.de> <30e4a070708080941j49b3d58cxc39bbe65f2fee9d5@mail.gmail.com> <Pine.LNX.4.64.0708081810130.14781@racer.site> <75EB313E-807D-44FB-A186-A151F182B47B@zib.de> <2F00D32E-8D0C-48D6-86E1-6F6E7611E364@zib.de> <7E22DF40-1E28-4B8A-B132-18B05136B5E9@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Aug 09 01:07:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIucb-0005Pu-EE
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 01:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760230AbXHHXHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 19:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751844AbXHHXHL
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 19:07:11 -0400
Received: from el-out-1112.google.com ([209.85.162.176]:18284 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760230AbXHHXHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 19:07:09 -0400
Received: by el-out-1112.google.com with SMTP id j27so85658elf
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 16:07:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=rx3oGdZ4ffL1UYwaI0Atylw9YhJFzsSy3gYuKVPcbVaWfekd4/wQv31/DUM3sAnd4J6BVC6YdU+MQd8VQfbT1ngpfQ9OAS6p4twVhfvHNpUNVSJ5s8rH3/14meIDsr4ylgixv4oLCIYQGTA7PlqSjsaLyqy7YspzaJkvhVZSwjk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bEKm/beRA8/x4vQw4EtRDvcuNlTJyp2YRxEHc/EvxUTjdWMB09qRlqN+hlWUjOAe2/+qnrqqDWC4S+vyUt6rUlpZDBnOvrTN8sXnmWOEJ6SUx52yH6qXct+rLXXD+0BjCHfrqfvM36hWC86p9L1P4cx/xtYw/yVyDfFv5u3TKmI=
Received: by 10.90.63.16 with SMTP id l16mr2373816aga.1186614428331;
        Wed, 08 Aug 2007 16:07:08 -0700 (PDT)
Received: from ?192.168.100.118? ( [71.246.233.117])
        by mx.google.com with ESMTPS id 29sm1554290wrl.2007.08.08.16.07.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Aug 2007 16:07:06 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <7E22DF40-1E28-4B8A-B132-18B05136B5E9@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55393>

Steffen Prohaska wrote:
>
Let me guess, you have Cygwin on the path along with Msys, and had it 
that way when you downloaded the package and it tried to build. Hmmm. 
Maybe Cygwin executables conflict with Msys executables. Nah. Couldn't 
be. Must be a bug.

Mark
