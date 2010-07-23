From: Ivan Uemlianin <ivan@llaisdy.com>
Subject: Re: unpack failed --- is my repos broken?
Date: Fri, 23 Jul 2010 10:38:15 +0100
Message-ID: <4C496307.9080704@llaisdy.com>
References: <4C45A7C5.1050601@llaisdy.com> <AANLkTimhS92IX7knat-1hQeGzCuJ1qMLVzwdvlST7kWO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 23 11:38:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcEi0-0005Yc-AH
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 11:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755356Ab0GWJiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 05:38:18 -0400
Received: from mail.ukfsn.org ([77.75.108.10]:53029 "EHLO mail.ukfsn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752867Ab0GWJiR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 05:38:17 -0400
Received: from localhost (smtp-filter.ukfsn.org [192.168.54.205])
	by mail.ukfsn.org (Postfix) with ESMTP id 25385DF64D
	for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:38:16 +0100 (BST)
Received: from mail.ukfsn.org ([192.168.54.25])
	by localhost (smtp-filter.ukfsn.org [192.168.54.205]) (amavisd-new, port 10024)
	with ESMTP id Laqb2o1sX9LP for <git@vger.kernel.org>;
	Fri, 23 Jul 2010 10:38:16 +0100 (BST)
Received: from ivan-uemlianins-macbook-pro.local (unknown [217.33.230.66])
	by mail.ukfsn.org (Postfix) with ESMTP id EDFCBDF64C
	for <git@vger.kernel.org>; Fri, 23 Jul 2010 10:38:15 +0100 (BST)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-GB; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <AANLkTimhS92IX7knat-1hQeGzCuJ1qMLVzwdvlST7kWO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151509>

Dear All

Thank you for your comments.  I apologise for my delayed response.

I think the local side is not the problem:  if I do a fresh clone, then 
when I try a push I get the same error.

For the moment I have deleted and recreated the git repos on the server 
(tedious but quick), and all seems well.  Is this an occasional fault I 
can expect with the smart-http backend?

See query about ssh under separate title.

With thanks and best wishes

Ivan

On 21/07/2010 17:12, Tay Ray Chuan wrote:
> Hi,
>
> On Tue, Jul 20, 2010 at 9:42 PM, Ivan Uemlianin<ivan@llaisdy.com>  wrote:
>    
>>     $ git push
>>     Password: ...
>>     Counting objects: 5, done.
>>     Delta compression using up to 2 threads.
>>     Compressing objects: 100% (3/3), done.
>>     Writing objects: 100% (3/3), 410 bytes, done.
>>     Total 3 (delta 2), reused 0 (delta 0)
>>     error: unpack failed: unpack-objects abnormal exit
>>      
> Have you checked for repository corruption on the local side? You
> might be pushing bad stuff to the server.
>
>    


-- 
============================================================
Ivan A. Uemlianin
Speech Technology Research and Development

                     ivan@llaisdy.com
                      www.llaisdy.com
                          llaisdy.wordpress.com
                      www.linkedin.com/in/ivanuemlianin

     "Froh, froh! Wie seine Sonnen, seine Sonnen fliegen"
                      (Schiller, Beethoven)
============================================================
